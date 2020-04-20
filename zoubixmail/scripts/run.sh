#! /usr/bin/env bash
set -e # exit on error

### Launch
# on remets les droits au carré
chown -R bernard:bernard /home/bernard
chown -R fred:fred /home/fred
chown -R cel:cel /home/cel
chown -R klara:klara /home/klara
chown -R postfix:postfix /var/spool/postfix
chown -R _rspamd:_rspamd /var/lib/rspamd
# on recree les bases de donnees Postfix
/usr/sbin/postmap /etc/postfix/local_recipient_map
/usr/sbin/postalias /etc/postfix/aliases
# on calcul des filtres sieve de base
/usr/sbin/sievec /var/mail/sieve/global/spam-global.sieve
/usr/sbin/sievec /var/mail/sieve/global/spam-global.sieve
/usr/sbin/sievec /var/mail/sieve/global/spam-global.sieve
# au cas ou on supprime le fichier pid de postfix
rm -f /var/spool/postfix/pid/*.pid
# on lance supervisord
exec /usr/bin/supervisord -n
### End of Launch
