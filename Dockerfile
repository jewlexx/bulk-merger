FROM ruby:3-alpine

COPY * /

WORKDIR /

# Install Ruby deps
RUN bundle install

ENTRYPOINT [ "bundle exec rake" ]