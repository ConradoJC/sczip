#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

NAME="sczip"
VERSION="$(awk '/^Version:/ {print $2}' "$PROJECT_DIR/sczip.spec")"
ARCH="amd64"

BUILD_DIR="/tmp/${NAME}_${VERSION}_${ARCH}"
DEB_DIR="$BUILD_DIR/DEBIAN"
BIN_DIR="$BUILD_DIR/usr/bin"

OUTPUT="$PROJECT_DIR/${NAME}_${VERSION}_${ARCH}.deb"

echo "========================================"
echo " SCZIP DEB BUILD"
echo "========================================"
echo
echo "Projeto:"
echo "  $PROJECT_DIR"
echo
echo "Pacote:"
echo "  ${NAME}_${VERSION}_${ARCH}"
echo

echo "[1/5] Verificando dependências..."

command -v dpkg-deb >/dev/null 2>&1 || {
    echo "Erro: dpkg-deb não está instalado."
    echo "No Debian/Ubuntu, instale o pacote dpkg."
    exit 1
}

echo "[2/5] Preparando estrutura..."

rm -rf "$BUILD_DIR"
mkdir -p "$DEB_DIR" "$BIN_DIR"

echo "[3/5] Copiando executável..."

install -m 0755 \
    "$PROJECT_DIR/sczip" \
    "$BIN_DIR/sczip"

echo "[4/5] Criando metadata Debian..."

cat > "$DEB_DIR/control" <<CONTROL
Package: sczip
Version: ${VERSION}
Section: utils
Priority: optional
Architecture: ${ARCH}
Maintainer: Conrado <conrado@example.com>
Depends: bash, rsync, zip
Description: Simple directory backup utility
 SCZip creates ZIP backups of the current directory.
 It reads a .scignore file using gitignore-style exclusion patterns.
 It does not require a Git repository.
CONTROL

echo "[5/5] Gerando .deb..."

rm -f "$OUTPUT"

dpkg-deb --build \
    --root-owner-group \
    "$BUILD_DIR" \
    "$OUTPUT"

rm -rf "$BUILD_DIR"

echo
echo "========================================"
echo " BUILD CONCLUÍDO"
echo "========================================"
echo
echo "DEB:"
echo "  $OUTPUT"
echo
echo "Informações:"
dpkg-deb --info "$OUTPUT"
echo
