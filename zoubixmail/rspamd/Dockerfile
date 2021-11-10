FROM debian:latest

LABEL descrption="Antispam server Zoubixmail " \
	version="0.1" \
	release-date="2021-11-01"

# Variables
ENV TZ=Europe/Paris
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update -qq && \
	apt-get install -qq -y --no-install-recommends rspamd \
		redis-server \
		nfs-common \
		rsyslog \
		nginx \
		supervisor

# Ajoutons les fichiers de config pour rspamd
ADD conf/rspamd/* /etc/rspamd/
#
# Ajoutons le fichier de config de rsyslog
ADD conf/rsyslog.conf /etc/rsyslog.conf
#
# Ajoutons le fichier de config supervisor
ADD conf/supervisor.conf /etc/supervisor/conf.d/
#
# Ajoutons les scripts de demarrage et configurons les
ADD scripts/dfg.sh /usr/local/bin/dfg.sh
ADD scripts/run.sh /root/run.sh
RUN chmod +x /usr/local/bin/dfg.sh
RUN chmod +x /root/run.sh
#
# Port RSPAMD
EXPOSE 11332
EXPOSE 11333
EXPOSE 11334

# Let's GO !
CMD ["/root/run.sh"]
