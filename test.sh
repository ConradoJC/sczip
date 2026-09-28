#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCZIP="$SCRIPT_DIR/sczip"

if [[ ! -x "$SCZIP" ]]; then
    echo "Erro: $SCZIP não existe ou não é executável."
    exit 1
fi

TEST_DIR="$(mktemp -d)"
trap 'rm -rf "$TEST_DIR"' EXIT

echo "========================================"
echo " SCZIP TEST"
echo "========================================"
echo
echo "Executável testado:"
echo "  $SCZIP"
echo

mkdir -p "$TEST_DIR/projeto"/{src,node_modules,dist,logs,uploads}

echo "codigo" > "$TEST_DIR/projeto/src/main.js"
echo "readme" > "$TEST_DIR/projeto/README.md"
echo "dependencia" > "$TEST_DIR/projeto/node_modules/lib.js"
echo "build" > "$TEST_DIR/projeto/dist/app.js"
echo "log" > "$TEST_DIR/projeto/logs/app.log"
echo "imagem" > "$TEST_DIR/projeto/uploads/image.png"
echo "importante" > "$TEST_DIR/projeto/uploads/important.txt"

cat > "$TEST_DIR/projeto/.scignore" <<'SCIGNORE'
node_modules/
dist/
*.log
!uploads/important.txt
SCIGNORE

cd "$TEST_DIR/projeto"

echo "Executando sczip..."
echo

printf 'y\n' | "$SCZIP"

ZIP="$(find . -maxdepth 1 -name 'backup_*.zip' -type f | head -n1)"

if [[ -z "$ZIP" ]]; then
    echo "ERRO: ZIP não foi criado."
    exit 1
fi

echo
echo "Verificando conteúdo do ZIP..."
echo

unzip -l "$ZIP"

echo
echo "Validando arquivos..."

unzip -l "$ZIP" | grep -q 'src/main.js'
unzip -l "$ZIP" | grep -q 'README.md'
unzip -l "$ZIP" | grep -q 'uploads/image.png'
unzip -l "$ZIP" | grep -q 'uploads/important.txt'

if unzip -l "$ZIP" | grep -q 'node_modules/'; then
    echo "ERRO: node_modules entrou no ZIP."
    exit 1
fi

if unzip -l "$ZIP" | grep -q 'dist/'; then
    echo "ERRO: dist entrou no ZIP."
    exit 1
fi

if unzip -l "$ZIP" | grep -q 'logs/'; then
    echo "ERRO: logs entrou no ZIP."
    exit 1
fi

if unzip -l "$ZIP" | grep -q '\.scignore'; then
    echo "ERRO: .scignore entrou no ZIP."
    exit 1
fi

echo
echo "========================================"
echo " TODOS OS TESTES PASSARAM"
echo "========================================"
