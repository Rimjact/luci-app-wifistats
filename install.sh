#!/bin/sh

REPOSITORY="https://raw.githubusercontent.com/Rimjact/luci-app-wifistats"
BRANCH="main"

install_depends() {
    echo "--- 🔃 Устанавливаем зависимости ---"
    echo "Зависимости: luci-base lua lua-cjson libubus-lua procd"

    apk update
    apk add luci-base lua lua-cjson libubus-lua procd

    echo "--- ✅ Зависимости установлены ---"
}

create_directories() {
    echo "--- 📁 Создаём директории ---"

    echo "/etc/init.d/"
    mkdir -p /etc/init.d/
    echo "/usr/bin"
    mkdir -p /usr/bin
    echo "/lib/lua/luci/controller"
    mkdir -p /lib/lua/luci/controller
    echo "/lib/lua/luci/view"
    mkdir -p /lib/lua/luci/view

    echo "/etc/wifistats"
    touch /etc/wifistats

    echo "--- ✅ Директории созданы ---"
}

download_file() {
    local file_path="$1"
    local dest="$2"

    echo "🔃 Скачиваем файл: $1"
    wget -q -O "$dest" "${REPOSITORY}/${BRANCH}/${file_path}" >/dev/null 2>&1 && return 0
}

download_project_files() {
    echo "--- ⚙️ Скачиваем файлы проекта ---"

    download_file "root/etc/init.d/wifistats" "/etc/init.d/wifistats"
    download_file "usr/bin/wifistats" "/usr/bin/wifistats"
    download_file "usr/lib/lua/luci/controller/wifistats.lua" "/usr/lib/lua/luci/contorller/wifistats.lua"
    download_file "usr/lib/lua/luci/view/wifistats.htm" "/usr/lib/lua/luci/view/wifistats.htm"

    echo "--- ✅ Файлы проекта скачаны ---"
}

start_daemon() {
    echo "--- 🛠️ Проводим последние приготовления ---"

    echo "📕 Регулируем права..."
    chmod 755 /etc/init.d/wifistats
    chmod 755 /usr/bin/wifistats
    chmod 644 /etc/wifistas

    echo "👾 Выпускаем демонов..."
    /etc/init.d/wifistats enable >/dev/null 2>&1 || true
    /etc/init.d/wifistats start >/dev/null 2>&1 || true
    /etc/init.d/uhttpd restart >/dev/null 2>&1 || true

    echo "--- ✅ Приготовления закончены ---"
}

install_project() {
    echo "=== ▶️ Начало установки Wi-Fi Stats ==="
    echo "🔹${REPOSITORY}/${BRANCH}"

    install_depends
    create_directories
    download_project_files
    start_daemon

    echo "=== 🎉 Wi-Fi Stats установлен ==="
    echo "Мониторинг доступен Статус -> Статистика Wi-Fi"
}

install_project