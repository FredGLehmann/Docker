FROM debian:latest

LABEL descrption="Serveur Mail famille Lehmann" \
	version="0.2" \
	release-date="2019-01-07"

RUN apt-get update && apt-get install -y \
	postfix \
	dovecot-core \
	dovecot-imapd \
	rspamd \
	opendkim \
	opendkim-tools \
	certbot \
	vim
