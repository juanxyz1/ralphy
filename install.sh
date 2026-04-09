#!/bin/bash
set -e

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Instalando ralphy..."

mkdir -p "$INSTALL_DIR"

# Symlink para que actualizaciones con git pull se reflejen automáticamente
ln -sf "$SCRIPT_DIR/ralphy" "$INSTALL_DIR/ralphy"
chmod +x "$SCRIPT_DIR/ralphy"

# Verificar PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠  $INSTALL_DIR no está en tu PATH."
    echo "   Añade esto a tu ~/.bashrc, ~/.zshrc o ~/.config/fish/config.fish:"
    echo ""
    echo "   export PATH=\"\$HOME/.local/bin:\$PATH\"    # bash/zsh"
    echo "   fish_add_path ~/.local/bin                  # fish"
    echo ""
fi

echo "✓ ralphy instalado en $INSTALL_DIR/ralphy"
echo ""
echo "Uso:"
echo "  cd tu-proyecto"
echo "  mkdir -p .ralph"
echo "  # Escribe tu prompt en .ralph/PROMPT.md"
echo "  ralphy        # 1 ejecución + 2 reviews"
echo "  ralphy 3      # 3 ejecuciones + 2 reviews"
