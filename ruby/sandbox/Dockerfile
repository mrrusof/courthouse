FROM ruby:2.4

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apt-get update && apt-get install -y time && apt-get autoremove && apt-get clean
RUN mkdir /input
RUN adduser --gecos '' --no-create-home --disabled-login --disabled-password --uid 9000 sandbox

ADD docker/sandbox.sh /

ENTRYPOINT /sandbox.sh

