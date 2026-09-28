#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SPEC_FILE="$PROJECT_DIR/sczip.spec"

NAME="$(awk '/^Name:/ {print $2}' "$SPEC_FILE")"
VERSION="$(awk '/^Version:/ {print $2}' "$SPEC_FILE")"

RPMBUILD="$HOME/rpmbuild"
SOURCE_DIR="/tmp/${NAME}-${VERSION}"

echo "========================================"
echo " SCZIP BUILD"
echo "========================================"
echo

echo "Projeto:"
echo "  $PROJECT_DIR"
echo

echo "Pacote:"
echo "  $NAME-$VERSION"
echo

echo "[1/5] Preparando estrutura RPM..."

mkdir -p \
    "$RPMBUILD/BUILD" \
    "$RPMBUILD/BUILDROOT" \
    "$RPMBUILD/RPMS" \
    "$RPMBUILD/SOURCES" \
    "$RPMBUILD/SPECS" \
    "$RPMBUILD/SRPMS"

echo "[2/5] Preparando código-fonte..."

rm -rf "$SOURCE_DIR"
mkdir -p "$SOURCE_DIR"

cp \
    "$PROJECT_DIR/sczip" \
    "$PROJECT_DIR/README.md" \
    "$PROJECT_DIR/LICENSE" \
    "$SOURCE_DIR/"

echo "[3/5] Criando tar.gz..."

tar -czf \
    "/tmp/${NAME}-${VERSION}.tar.gz" \
    -C /tmp \
    "${NAME}-${VERSION}"

cp \
    "/tmp/${NAME}-${VERSION}.tar.gz" \
    "$RPMBUILD/SOURCES/"

echo "[4/5] Preparando SPEC..."

cp "$SPEC_FILE" "$RPMBUILD/SPECS/"

echo "[5/5] Gerando RPM..."

rpmbuild -ba "$RPMBUILD/SPECS/${NAME}.spec"

echo
echo "========================================"
echo " BUILD CONCLUÍDO"
echo "========================================"
echo
echo "RPM:"
find "$RPMBUILD/RPMS" -type f -name "${NAME}-*.rpm" -print
echo
echo "Source RPM:"
find "$RPMBUILD/SRPMS" -type f -name "${NAME}-*.src.rpm" -print
echo
