FROM ruby:3-alpine

COPY * /

WORKDIR /

# Install Ruby deps
RUN bundler install

ENTRYPOINT [ "bundle exec rake" ]