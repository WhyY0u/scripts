#!/usr/bin/env fish

echo "✅ Очистка"
functions -e initdotvs
functions -e initvs
functions -e createcomp

function createcomp
    set first $argv[1]
    set second $argv[2]
    set args $argv[3..-1]

    if test "$first" = "--react"
        switch $second
            case --ts
                set ts_script "$HOME/scripts/react/ts/create-component-react-ts.sh"
                if test -x $ts_script
                    echo "🚀 Запуск TypeScript скрипта..."
                    $ts_script $args
                else
                    echo "❌ Скрипт $ts_script не найден или не исполняемый"
                end

            case --js
                set js_script "$HOME/scripts/react/js/create-component-react-js.sh"
                if test -x $js_script
                    echo "🚀 Запуск JavaScript скрипта..."
                    $js_script $args
                else
                    echo "❌ Скрипт $js_script не найден или не исполняемый"
                end

            case '*'
                echo "❗ Уточни язык: --ts или --js"
        end
    else
        echo "❌ Неизвестный флаг: $first"
        echo "📌 Использование: createcomp --react --ts [доп.аргументы]"
        echo "                    или createcomp --react --js [доп.аргументы]"
    end
end


function initdotvs
    set first $argv[1]
    set second $argv[2]

    if test "$first" = "--react"
        set base_dest "$PWD"

        switch $second
            case --ts
                set vscode_source "$HOME/scripts/initdotvs/reactts/.vscode"
            case --js
                set vscode_source "$HOME/scripts/initdotvs/react/.vscode"
            case '*'
                echo "❗ Уточни язык: --ts или --js"
                return 1
        end

        if test -d $vscode_source
            cp -r $vscode_source "$base_dest"
            echo "✅ Папка .vscode скопирована из $vscode_source"
        else
            echo "❌ Папка $vscode_source не найдена"
            return 1
        end
    else
        echo "❌ Неизвестный флаг: $first"
        echo "📌 Использование: initdotvs --react --ts или initdotvs --react --js"
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
funcsave createcomp