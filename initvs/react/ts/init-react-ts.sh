#!/bin/bash

REPO="git@github.com:WhyY0u/React-TS-Template.git"

echo "🚀 Клонируем шаблон прямо в текущую папку: $(pwd)"
git clone "$REPO" . 2> /dev/null

if [ $? -ne 0 ]; then
  echo "❌ Не удалось клонировать. Убедись, что текущая папка пуста."
  exit 1
fi

echo "📦 Выберите менеджер пакетов:"
echo "1) pnpm"
echo "2) yarn"
echo "3) npm"
read -p "👉 Введите номер (по умолчанию: 1): " choice

choice=${choice:-1}

case $choice in
  1)
    if ! command -v pnpm &> /dev/null; then
      echo "⚠️ pnpm не найден. Устанавливаем..."
      npm install -g pnpm || { echo "❌ Ошибка при установке pnpm"; exit 1; }
    fi
    echo "📦 Установка зависимостей через pnpm..."
    pnpm install
    ;;
  2)
    if ! command -v yarn &> /dev/null; then
      echo "⚠️ yarn не найден. Устанавливаем..."
      npm install -g yarn || { echo "❌ Ошибка при установке yarn"; exit 1; }
    fi
    echo "📦 Установка зависимостей через yarn..."
    yarn
    ;;
  3)
    echo "📦 Установка зависимостей через npm..."
    npm install
    ;;
  *)
    echo "❌ Неверный выбор"
    exit 1
    ;;
esac

echo "✅ Проект установлен в: $(pwd)"

if command -v code &>/dev/null; then
  code .
fi
