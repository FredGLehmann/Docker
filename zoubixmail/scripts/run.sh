#! /usr/bin/env bash
set -e # exit on error

# Launch
rm -f /var/spool/postfix/pid/*.pid
/usr/sbin/postmap /etc/postfix/local_recipient_map
/usr/sbin/postalias /etc/postfix/aliases
chown -R postfix:postfix /var/spool/postfix
chown -R _rspamd:_rspamd /var/lib/rspamd
exec /usr/bin/supervisord -n
