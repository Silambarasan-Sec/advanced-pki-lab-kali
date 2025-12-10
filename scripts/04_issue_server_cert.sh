#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/pki-lab"
SUB_DIR="$BASE_DIR/sub"
CONF_SUB="$(cd "$(dirname "${BASH_SOURCE[0]}")/../config" && pwd)/openssl-sub.cnf"

SERVER_DIR="$BASE_DIR/server"
mkdir -p "$SERVER_DIR"

echo "[*] Creating server key..."
openssl genrsa -out "$SERVER_DIR/server.key" 2048

echo "[*] Creating server CSR with SAN..."
cat > "$SERVER_DIR/server.cnf" <<EOF
[ req ]
prompt = no
distinguished_name = dn
req_extensions = ext

[ dn ]
CN = myserver.local

[ ext ]
subjectAltName = @alt_names
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

[ alt_names ]
DNS.1 = myserver.local
DNS.2 = localhost
IP.1 = 127.0.0.1
EOF

openssl req -new \
  -key "$SERVER_DIR/server.key" \
  -out "$SERVER_DIR/server.csr" \
  -config "$SERVER_DIR/server.cnf"

echo "[*] Signing server certificate with Sub CA..."
openssl ca -config "$CONF_SUB" \
  -extensions server_cert \
  -in "$SERVER_DIR/server.csr" \
  -out "$SERVER_DIR/server.crt" \
  -batch

echo "[+] Server certificate issued at $SERVER_DIR/server.crt"
