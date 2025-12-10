#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/pki-lab"

echo "[*] Creating PKI lab directories in $BASE_DIR ..."

mkdir -p "$BASE_DIR/root"/{certs,crl,newcerts,private}
mkdir -p "$BASE_DIR/sub"/{certs,crl,newcerts,private,csr}
mkdir -p "$BASE_DIR"/client

touch "$BASE_DIR/root/index.txt"
touch "$BASE_DIR/sub/index.txt"

echo 1000 > "$BASE_DIR/root/serial"
echo 2000 > "$BASE_DIR/sub/serial"

echo "[+] PKI directories initialized."
