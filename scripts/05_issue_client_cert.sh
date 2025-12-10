#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/pki-lab"
SUB_DIR="$BASE_DIR/sub"
CLIENT_DIR="$BASE_DIR/client"
CONF_SUB="$(cd "$(dirname "${BASH_SOURCE[0]}")/../config" && pwd)/openssl-sub.cnf"

mkdir -p "$CLIENT_DIR"

echo "[*] Creating client key..."
openssl genrsa -out "$CLIENT_DIR/client.key" 2048

echo "[*] Creating client CSR..."
openssl req -new \
  -key "$CLIENT_DIR/client.key" \
  -out "$CLIENT_DIR/client.csr" \
  -subj "/CN=pki-client"

echo "[*] Signing client certificate with Sub CA..."
openssl ca -config "$CONF_SUB" \
  -extensions usr_cert \
  -in "$CLIENT_DIR/client.csr" \
  -out "$CLIENT_DIR/client.crt" \
  -batch

echo "[+] Client certificate issued at $CLIENT_DIR/client.crt"
