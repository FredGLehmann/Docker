FROM debian:latest

LABEL descrption="Projet tatooine (image publishing)" \
	version="0.2" \
	release-date="2019-01-07"

RUN apt-get update && apt-get install -y \
	python \
	python-pip \
	apache2-utils \
	git \
	curl \
	vim

RUN pip install awscli --upgrade
 
WORKDIR /tmp
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

WORKDIR /root
RUN mkdir .aws
