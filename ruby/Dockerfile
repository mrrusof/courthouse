FROM alpine:3.6

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apk update && \
    apk add openrc \
            make \
            docker \
            python \
            grep \
            bash

RUN mkdir /input

ADD docker/*.sh /judge/
ADD sandbox/script/*.sh /judge/

CMD /judge/judge.sh
