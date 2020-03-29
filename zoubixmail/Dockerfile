FROM debian:latest

LABEL descrption="Serveur Mail famille Lehmann" \
	version="0.2" \
	release-date="2019-01-07"

# Varaibles
ENV TZ=Europe/Paris
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update -qq && \
	apt-get install -qq -y --no-install-recommends postfix \
		dovecot-core \
		dovecot-imapd \
		rspamd \
		opendkim \
		opendkim-tools \
		nfs-common \
		rsyslog \
		supervisor

# Ajoutons les fichiers de config
ADD conf/main.cf /etc/postfix/main.cf
ADD conf/mailname /etc/mailname
ADD conf/rsyslog.conf /etc/rsyslog.conf
ADD conf/supervisor.conf /etc/supervisor/conf.d/
# Ajoutons les scripts et configurons les
ADD scripts/dfg.sh /usr/local/bin/dfg.sh
ADD scripts/run.sh /root/run.sh
RUN chmod +x /usr/local/bin/dfg.sh
RUN chmod +x /root/run.sh

# Configuration des ports réseau
EXPOSE 25

# Let's GO !
CMD ["/root/run.sh"]
