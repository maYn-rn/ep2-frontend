#!/bin/sh
set -eu

# Estas variables se configuran en docker-compose del frontend (en EC2 pública)
# Ejemplos:
# - VENTAS_URL="http://10.0.2.10:8080"
# - DESPACHOS_URL="http://10.0.2.10:8081"
: "${VENTAS_URL:=}"
: "${DESPACHOS_URL:=}"

cat > /usr/share/nginx/html/env.js <<EOF
window.__ENV__ = {
  VENTAS_URL: "${VENTAS_URL}",
  DESPACHOS_URL: "${DESPACHOS_URL}"
};
EOF

exec "$@"

