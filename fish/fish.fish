#!/usr/bin/env fish

echo "✅ Очистка"
functions -e initdotvs
functions -e initvs

function initdotvs
    set option $argv[1]

    switch $option
        case --react
            set source_dir ~/scripts/initdotvs/react/.vscode
            if test -d $source_dir
                cp -r $source_dir .
                echo "✅ VSCode для React скопирован!"
            else
                echo "❌ Папка $source_dir не найдена"
            end
        case '*'
            echo "❌ Неизвестный флаг: $option"
            echo "Использование: initdotvs --react"
    end
end


function initvs
    set option $argv[1]

    switch $option
        case --vite
            echo "🚀 Создание Vite-проекта в текущей директории..."
            npm create vite@latest
        case '*'
            echo "❌ Неизвестный флаг: $option"
            echo "Использование: initvs --vite"
    end
end

echo "✅ Установка"
funcsave initvs
funcsave initdotvs