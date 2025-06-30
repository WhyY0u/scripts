#!/bin/bash

read -p "📁 Введите путь (относительно проекта): " REL_PATH
read -p "📦 Имя компонента: " NAME

if [ -z "$REL_PATH" ] || [ -z "$NAME" ]; then
  echo "❌ Требуется путь и имя компонента."
  exit 1
fi

DIR="./$REL_PATH/$NAME"
STYLE_DIR="$DIR/style"
TSX="$DIR/$NAME.tsx"
CSS="$STYLE_DIR/style.module.css"

mkdir -p "$STYLE_DIR"

cat > "$TSX" <<EOF
import styles from './style/style.module.css';
import React from 'react';

interface ${NAME}Props {

}

const $NAME: React.FC<${NAME}Props> = () => {
  return (
    <div className={styles.container}>

    </div>
  );
};

export default $NAME;
EOF

cat > "$CSS" <<EOF
.container {

}
EOF

echo "✅ TypeScript-компонент $NAME создан в $DIR"
