#!/bin/bash

if [[ -z $(git status --porcelain) ]]; then
  echo "❌ Нет изменений для коммита."
  exit 1
fi

git add .

DIFF=$(git diff --cached)

COMMIT_MSG=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
    "model": "gpt-4",
    "messages": [
      {"role": "system", "content": "Ты помогаешь писать краткие commit-сообщения на русском языке."},
      {"role": "user", "content": "На основе этих изменений в git напиши короткое и понятное сообщение коммита:\n'"$DIFF"'"}
    ]
  }' | jq -r '.choices[0].message.content')

if [[ -z "$COMMIT_MSG" ]]; then
  echo "❌ Не удалось сгенерировать сообщение."
  exit 1
fi

# Коммит и пуш
git commit -m "$COMMIT_MSG"
git push

echo "✅ Запушено с комментарием: $COMMIT_MSG"