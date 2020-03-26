#! /usr/bin/env bash
set -e # exit on error

# Launch
rm -f /var/spool/postfix/pid/*.pid
exec /usr/bin/supervisord -n
