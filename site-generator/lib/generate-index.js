'use strict'

/*
  MIT License

  Copyright (c) 2018 Guillaume Grossetie

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*/

const lunr = require('lunr')
const cheerio = require('cheerio')
const Entities = require('html-entities').AllHtmlEntities
const entities = new Entities()

/**
 * Generate a Lunr index.
 *
 * Iterates over the specified pages and creates a Lunr index.
 *
 * @memberof generate-index
 *
 * @param {Object} playbook - The configuration object for Antora.
 * @param {Object} playbook.site - Site-related configuration data.
 * @param {String} playbook.site.url - The base URL of the site.
 * @param {Array<File>} pages - The publishable pages to map.
 * @returns {Object} A JSON object with a Lunr index and a documents store.
 */
function generateIndex (playbook, pages) {
  let siteUrl = playbook.site.url
  if (!siteUrl) {
    // Uses relative links when site URL is not set
    siteUrl = ''
  }
  if (siteUrl.charAt(siteUrl.length - 1) === '/') siteUrl = siteUrl.substr(0, siteUrl.length - 1)
  const urlPath = extractUrlPath(siteUrl)
  if (!pages.length) return {}
  // Map of Lunr ref to document
  const documentsStore = {}
  const documents = pages
    .map((page) => {
      const html = page.contents.toString()
      const $ = cheerio.load(html)
      return { page, $ }
    })
    // Exclude pages marked as "noindex"
    .filter(({ page, $ }) => {
      const $metaRobots = $('meta[name=robots]')
      return !(($metaRobots && $metaRobots.attr('content') === 'noindex') || (page.asciidoc && page.asciidoc.attributes && page.asciidoc.attributes.noindex === ''))
    })
    .map(({ page, $ }) => {
      // Fetch just the article content, so we don't index the TOC and other on-page text
      // Remove any found headings, to improve search results
      const article = $('article.doc .contents')
      const $h1 = $('h1', article)
      const documentTitle = $h1.first().text()
      $h1.remove()
      const titles = []
      $('h2,h3,h4,h5,h6', article).each(function () {
        let $title = $(this)
        // If the title does not have an Id then Lunr will throw a TypeError
        // cannot read property 'text' of undefined.
        if ($title.attr('id')) {
          titles.push({
            text: $title.text(),
            id: $title.attr('id')
          })
        }
        $title.remove()
      })

      // Pull the text from the article, and convert entities
      let text = article.text()
      // Decode HTML
      text = entities.decode(text)
      // Strip HTML tags
      text = text.replace(/(<([^>]+)>)/ig, '')
        .replace(/\n/g, ' ')
        .replace(/\r/g, ' ')
        .replace(/\s+/g, ' ')
        .trim()

      // Return the indexable content, organized by type
      return {
        text: text,
        title: documentTitle,
        component: page.src.component,
        version: page.src.version,
        name: page.src.stem,
        url: urlPath + page.pub.url,
        titles: titles // TODO get title id to be able to use fragment identifier
      }
    })

  // Construct the lunr index from the composed content
  const lunrIndex = lunr(function () {
    const self = this
    self.ref('url')
    self.field('title', { boost: 10 })
    self.field('name')
    self.field('text')
    self.field('component')
    self.metadataWhitelist = ['position']
    documents.forEach(function (doc) {
      self.add(doc)
      doc.titles.forEach(function (title) {
        self.add({
          title: title.text,
          url: `${doc.url}#${title.id}`
        })
      }, self)
    }, self)
  })

  // Place all indexed documents into the store
  documents.forEach(function (doc) {
    documentsStore[doc.url] = doc
  })

  // Return the completed index, store, and component map
  return {
    index: lunrIndex,
    store: documentsStore
  }
}
// Extract the path from an URL
function extractUrlPath (url) {
  if (url) {
    if (url.charAt() === '/') return url
    const urlPath = new URL(url).pathname
    return urlPath === '/' ? '' : urlPath
  }
  return ''
}

// Helper function allowing Antora to create a site asset containing the index
function createIndexFile (index) {
  return {
    mediaType: 'text/javascript',
    contents: Buffer.from(`window.antoraLunr.init(${JSON.stringify(index)})`),
    src: { stem: 'search-index' },
    out: { path: 'search-index.js' },
    pub: { url: '/search-index.js', rootPath: '' }
  }
}

module.exports = generateIndex
module.exports.createIndexFile = createIndexFile