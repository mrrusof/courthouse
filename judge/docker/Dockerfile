FROM debian:jessie-slim

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apt-get update && \
    apt-get install -y jshon curl && \
    apt-get autoremove && \
    apt-get clean && \
    \
    mkdir -p /tmp/download && \
    curl -L https://get.docker.com/builds/Linux/x86_64/docker-17.03.1-ce.tgz | tar -xz -C /tmp/download && \
    rm -rf /tmp/download/docker/dockerd && \
    mv /tmp/download/docker/docker* /usr/local/bin/ && \
    rm -rf /tmp/download

ADD *.sh /judge/

CMD /judge/judge.sh
