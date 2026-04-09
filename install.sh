#!/bin/bash
set -e

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RALPHY_SRC="$SCRIPT_DIR/ralphy"

echo "Instalando ralphy..."

# Validar que el script fuente existe
if [[ ! -f "$RALPHY_SRC" ]]; then
    echo "Error: no se encontró $RALPHY_SRC"
    exit 1
fi

# Hacer ejecutable antes de crear el symlink
chmod +x "$RALPHY_SRC"

mkdir -p "$INSTALL_DIR"

# Symlink para que actualizaciones con git pull se reflejen automáticamente
ln -sf "$RALPHY_SRC" "$INSTALL_DIR/ralphy"

# Verificar PATH y mostrar instrucciones según el shell del usuario
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠  $INSTALL_DIR no está en tu PATH."
    case "${SHELL:-}" in
        */fish)
            echo "   Ejecuta: fish_add_path ~/.local/bin" ;;
        */zsh)
            echo "   Añade a ~/.zshrc: export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
        *)
            echo "   Añade a ~/.bashrc: export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
    esac
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
