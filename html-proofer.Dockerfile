FROM ruby:2.7.0-alpine

RUN echo 'gem: --no-document' >> /etc/gemrc

# needed at runtime
RUN apk add --no-cache  libcurl xz-libs

RUN apk add --no-cache --virtual build-dependencies \
  build-base \
  libxml2-dev \
  libxslt-dev \
  && gem install html-proofer \
  && apk del build-dependencies

ENTRYPOINT ["htmlproofer"]
CMD ["--help"]