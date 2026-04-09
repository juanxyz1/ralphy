#!/bin/bash
set -e

INSTALL_DIR="$HOME/.local/bin"
TARGET="$INSTALL_DIR/ralphy"

echo "Desinstalando ralphy..."

if [[ ! -e "$TARGET" ]]; then
    echo "✓ ralphy no está instalado en $INSTALL_DIR"
    exit 0
fi

# Verificar que es un symlink (no un binario ajeno)
if [[ ! -L "$TARGET" ]]; then
    echo "⚠  $TARGET existe pero NO es un symlink creado por ralphy."
    echo "   No se eliminará automáticamente. Revísalo manualmente."
    exit 1
fi

rm -f "$TARGET"

echo "✓ ralphy desinstalado"
