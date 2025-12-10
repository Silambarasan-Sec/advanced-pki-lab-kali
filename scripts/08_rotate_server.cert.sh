#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/pki-lab"
SUB_DIR="$BASE_DIR/sub"
SERVER_DIR="$BASE_DIR/server"
CONF_SUB="$(cd "$(dirname "${BASH_SOURCE[0]}")/../config" && pwd)/openssl-sub.cnf"

echo "[*] Generating new server key..."
openssl genrsa -out "$SERVER_DIR/server_new.key" 2048

echo "[*] Creating new server CSR..."
openssl req -new \
  -key "$SERVER_DIR/server_new.key" \
  -out "$SERVER_DIR/server_new.csr" \
  -subj "/CN=myserver.local"

echo "[*] Signing new server certificate..."
openssl ca -config "$CONF_SUB" \
  -extensions server_cert \
  -in "$SERVER_DIR/server_new.csr" \
  -out "$SERVER_DIR/server_new.crt" \
  -batch

mv "$SERVER_DIR/server_new.key" "$SERVER_DIR/server.key"
mv "$SERVER_DIR/server_new.crt" "$SERVER_DIR/server.crt"

sudo cp "$SERVER_DIR/server.crt" /etc/nginx/server.crt
sudo cp "$SERVER_DIR/server.key" /etc/nginx/server.key

echo "[+] Server certificate rotated. Restart Nginx to apply."
