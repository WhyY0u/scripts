#!/bin/bash

read -p "📁 Введите путь (относительно проекта): " REL_PATH
read -p "📦 Имя компонента: " NAME

if [ -z "$REL_PATH" ] || [ -z "$NAME" ]; then
  echo "Требуется путь и имя компонента."
  exit 1
fi

DIR="./$REL_PATH/$NAME"
STYLE_DIR="$DIR/style"
JSX="$DIR/$NAME.jsx"
CSS="$STYLE_DIR/style.module.css"

mkdir -p "$STYLE_DIR"

cat > "$JSX" <<EOF
import styles from './style/style.module.css'

function $NAME() {
  return (
    <>
    
    </>
  );
}

export default $NAME;
EOF

touch "$CSS"

echo "✅ Компонент $NAME создан в $DIR"
