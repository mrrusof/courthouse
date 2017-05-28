FROM ruby:2.4

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apt-get update && \
    apt-get install time && \
    mkdir /run/judge

COPY ["judge.sh", "/"]

ENTRYPOINT ["/judge.sh"]