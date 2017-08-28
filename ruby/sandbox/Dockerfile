FROM ruby:2.4

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apt-get update && \
    apt-get install -y time jshon sudo && \
    apt-get autoremove && \
    apt-get clean && \
    adduser --gecos '' --no-create-home --disabled-login --disabled-password --uid 9000 sandbox

ADD docker/sandbox.sh /

ENTRYPOINT ["/sandbox.sh"]

