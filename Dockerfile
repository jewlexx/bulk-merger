FROM ruby:3-alpine

COPY * /

ENTRYPOINT [ "/bulk-merger.sh" ]