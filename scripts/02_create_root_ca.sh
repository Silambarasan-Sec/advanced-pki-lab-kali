#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/pki-lab"
ROOT_DIR="$BASE_DIR/root"
CONF_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../config" && pwd)/openssl-root.cnf"

echo "[*] Generating Root CA private key..."
openssl genrsa -out "$ROOT_DIR/private/root.key" 4096

echo "[*] Creating Root CA certificate..."
openssl req -config "$CONF_ROOT" \
  -key "$ROOT_DIR/private/root.key" \
  -new -x509 -days 3650 -sha256 \
  -out "$ROOT_DIR/root.crt"

echo "[+] Root CA created at $ROOT_DIR/root.crt"
