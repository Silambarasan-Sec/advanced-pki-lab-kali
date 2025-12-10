#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/pki-lab"
ROOT_DIR="$BASE_DIR/root"
SUB_DIR="$BASE_DIR/sub"

CONF_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../config" && pwd)/openssl-root.cnf"
CONF_SUB="$(cd "$(dirname "${BASH_SOURCE[0]}")/../config" && pwd)/openssl-sub.cnf"

echo "[*] Generating Sub CA private key..."
openssl genrsa -out "$SUB_DIR/private/sub.key" 4096

echo "[*] Creating Sub CA CSR..."
openssl req -config "$CONF_SUB" \
  -new -key "$SUB_DIR/private/sub.key" \
  -out "$SUB_DIR/csr/sub.csr"

echo "[*] Signing Sub CA CSR with Root CA..."
openssl ca -config "$CONF_ROOT" \
  -extensions v3_intermediate_ca \
  -in "$SUB_DIR/csr/sub.csr" \
  -out "$SUB_DIR/sub.crt" \
  -batch

echo "[+] Sub CA created at $SUB_DIR/sub.crt"
