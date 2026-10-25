#!/bin/sh
# Render /etc/xray/config.json from the template using Railway env vars.
# PORT is injected by Railway; UUID and WS_PATH are set as service variables.
set -e
PORT="${PORT:-8080}"
UUID="${UUID:?UUID env var is required}"
WS_PATH="${WS_PATH:-/vless}"

sed -e "s/__PORT__/${PORT}/g" \
    -e "s/__UUID__/${UUID}/g" \
    -e "s#__WS_PATH__#${WS_PATH}#g" \
    /etc/xray/config.template.json > /etc/xray/config.json

exec /usr/local/bin/xray -c /etc/xray/config.json
