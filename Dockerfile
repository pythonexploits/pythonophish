FROM alpine:latest
LABEL MAINTAINER="https://github.com/pythonexploits/pythonophish"
WORKDIR /pythonophish/
ADD . /pythonophish
RUN apk add --no-cache bash ncurses curl unzip wget php 
CMD "./phishing.sh"
