#! /usr/bin/env bash
set -e # exit on error

# Launch
rm -f /var/spool/postfix/pid/*.pid
chown -R bernard:bernard /home/bernard
chown -R fred:fred /home/fred
chown -R cel:cel /home/cel
chown -R klara:klara /home/klara
chown -R postfix:postfix /var/spool/postfix
chown -R _rspamd:_rspamd /var/lib/rspamd
/usr/sbin/postmap /etc/postfix/local_recipient_map
/usr/sbin/postalias /etc/postfix/aliases
exec /usr/bin/supervisord -n
