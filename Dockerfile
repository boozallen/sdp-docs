FROM node:14.5.0 as generator
RUN mkdir /generator
COPY site-generator/ /generator
WORKDIR /generator
RUN npm i && npm pack
RUN ls /generator/booz-allen-site-generator-1.0.0.tgz

FROM antora/antora:2.3.0
ENV NODE_OPTIONS="--max-old-space-size=8192"
COPY --from=generator /generator/booz-allen-site-generator-1.0.0.tgz . 
# determined from antora-lunr dependencies
# link: https://github.com/Mogztter/antora-lunr/blob/v0.6.0/package.json#L29-L33
RUN yarn global add lunr@2.3.8 html-entities@^1.2.1 cheerio@^1.0.0-rc.2 file:$(pwd)/booz-allen-site-generator-1.0.0.tgz 
