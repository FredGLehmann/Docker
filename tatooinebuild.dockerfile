FROM debian:latest

LABEL descrption="Projet tatooine (image publishing) - Container pour le build" \
	version="0.1" \
	release-date="2019-02-01"

RUN apt-get update && apt-get install -y \
	gnupg \
	zip \
	curl

WORKDIR /tmp
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

WORKDIR /
RUN apt-get clean
