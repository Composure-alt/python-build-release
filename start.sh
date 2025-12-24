#!/bin/sh

# Скрипт запуска Python-приложений внутри контейнера
# 1. Показывает версию Python
# 2. Проверяет и устанавливает зависимости из requirements.txt
# 3. Запускает указанное приложение

echo "=== Запускается контейнер с Python версии: $(python --version) ==="

# Проверка наличия requirements.txt
if [ -f "requirements.txt" ]; then
    echo "Найден requirements.txt — создаю виртуальное окружение и устанавливаю зависимости..."
    pip install --no-cache-dir -r requirements.txt

    # Проверка успешности установки зависимостей
    if [ $? -eq 0 ]; then
        echo "Зависимости успешно установлены."
    else
        echo "Ошибка при установке зависимостей!"
        exit 1
    fi
else
    echo "requirements.txt не найден — пропускаю установку зависимостей"
fi

# Запуск приложения с аргументами
echo "=== Запуск Python-приложения ==="
exec python "$@"
