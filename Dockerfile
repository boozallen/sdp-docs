FROM antora/antora:2.3.0

# determined from antora-lunr dependencies
# link: https://github.com/Mogztter/antora-lunr/blob/v0.6.0/package.json#L29-L33
RUN yarn global add lunr@2.3.8 html-entities@^1.2.1 cheerio@^1.0.0-rc.2 