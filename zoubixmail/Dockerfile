FROM debian:latest

LABEL descrption="Serveur Mail famille Lehmann" \
	version="0.2" \
	release-date="2019-01-07"

# Varaibles
ENV TZ=Europe/Paris
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update -qq && \
	apt-get install -qq -y --no-install-recommends postfix \
		dovecot-imapd \
		dovecot-lmtpd \
		dovecot-sieve \
		rspamd \
		redis-server \
		opendkim \
		opendkim-tools \
		nfs-common \
		rsyslog \
		supervisor

# Ajoutons les fichiers de config pour postfix et dovecot
ADD conf/postfix/main.cf /etc/postfix/main.cf
ADD conf/mailname /etc/mailname
ADD conf/postfix/local_recipient_map /etc/postfix/local_recipient_map
ADD conf/postfix/aliases /etc/postfix/aliases
#
# Gestion des certificats
RUN mkdir /etc/postfix/certs
RUN chmod 600 /etc/postfix/certs
ADD conf/certs/smtp.zoubix.net.pem /etc/postfix/certs/smtp.zoubix.net.pem
ADD conf/certs/smtp.zoubix.net.key /etc/postfix/certs/smtp.zoubix.net.key
RUN chmod 400 /etc/postfix/certs/mail.zoubix.net.pem
RUN chmod 400 /etc/postfix/certs/mail.zoubix.net.key
#
# Ajoutons les fichiers de config pour dovecot
ADD conf/dovecot/dovecot.conf /etc/dovecot/dovecot.conf
ADD conf/dovecot/conf.d/* /etc/dovecot/conf.d/
#
# Ajoutons les fichiers de config pour dovecot-sieve
RUN mkdir -p /var/mail/sieve/global
ADD conf/sieve/* /var/mail/sieve/global/
#
# Ajoutons les fichiers de config pour rspamd
ADD conf/rspamd/* /etc/rspamd/
#
# Ajoutons le fichier de config de rsyslog
ADD conf/rsyslog.conf /etc/rsyslog.conf
#
# Ajoutons le fichier de config supervisor
ADD conf/supervisor.conf /etc/supervisor/conf.d/
#
# Ajoutons le fichier de config sopendkim
RUN mkdir /etc/opendkim
ADD conf/opendkim/opendkim.conf /etc/opendkim/opendkim.conf
ADD conf/opendkim/opendkim.key /etc/opendkim/opendkim.key
ADD conf/opendkim/opendkim.pub.key /etc/opendkim/opendkim.pub.key
ADD conf/opendkim/default_opendkim /etc/default/opendkim
ADD conf/opendkim/keytable /etc/opendkim/keytable
ADD conf/opendkim/SigningTable /etc/opendkim/SigningTable
ADD conf/opendkim/TrustedHosts /etc/opendkim/TrustedHosts
#
# Ajoutons les scripts de demarrage et configurons les
ADD scripts/dfg.sh /usr/local/bin/dfg.sh
ADD scripts/run.sh /root/run.sh
RUN chmod +x /usr/local/bin/dfg.sh
RUN chmod +x /root/run.sh
#
# Creons les utilisateurs
RUN useradd -d /home/fred fred
RUN useradd -d /home/klara klara
RUN useradd -d /home/cel cel
RUN useradd -d /home/bernard bernard

# Port SMTP
EXPOSE 25
# Port IMAP & IMAPS
EXPOSE 143
EXPOSE 993

# Let's GO !
CMD ["/root/run.sh"]
