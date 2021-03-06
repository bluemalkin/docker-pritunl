#!/bin/sh
set -e

if [ -z "$PRITUNL_MONGODB_URI" ]; then
  echo "ERROR: no PRITUNL_MONGODB_URI provided"
  exit
fi

if [ -z "$PRITUNL_DEBUG" ]; then
  PRITUNL_DEBUG="false"
fi

if [ -z "$PRITUNL_BIND_ADDR" ]; then
  PRITUNL_BIND_ADDR="0.0.0.0"
fi

TEMP_PATH=`mktemp -d --suffix _pritunl`

cat << EOF > /etc/pritunl.conf
{
    "mongodb_uri": "$PRITUNL_MONGODB_URI",
    "log_path": "/var/log/pritunl.log",
    "static_cache": true,
    "temp_path": "$TEMP_PATH",
    "debug": $PRITUNL_DEBUG,
    "bind_addr": "$PRITUNL_BIND_ADDR",
    "www_path": "/usr/share/pritunl/www",
    "local_address_interface": "auto",
    "port": 443
}
EOF

exec /usr/bin/pritunl start -c /etc/pritunl.conf
