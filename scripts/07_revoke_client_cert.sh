#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/pki-lab"
SUB_DIR="$BASE_DIR/sub"
CLIENT_DIR="$BASE_DIR/client"
CONF_SUB="$(cd "$(dirname "${BASH_SOURCE[0]}")/../config" && pwd)/openssl-sub.cnf"

echo "[*] Revoking client certificate..."
openssl ca -config "$CONF_SUB" \
  -revoke "$CLIENT_DIR/client.crt" \
  -batch

echo "[*] Generating new CRL..."
openssl ca -config "$CONF_SUB" \
  -gencrl -out "$SUB_DIR/sub.crl"

echo "[*] Copying CRL to /etc/nginx/sub.crl..."
sudo cp "$SUB_DIR/sub.crl" /etc/nginx/sub.crl

echo "[+] Client certificate revoked and CRL updated."
