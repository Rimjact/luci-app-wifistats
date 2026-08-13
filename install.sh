#!/bin/sh

REPOSITORY="https://raw.githubusercontent.com/Rimjact/luci-app-wifistats"
BRANCH="main"

install_depends() {
    echo "--- 🔃 Устанавливаем зависимости ---"
    echo "Зависимости: luci-base lua lua-cjson luci-lua-runtime libubus-lua liblucihttp-lua procd"

    apk update
    apk add luci-base lua lua-cjson luci-lua-runtime libubus-lua liblucihttp-lua procd

    echo "--- ✅ Зависимости установлены ---"
}

create_directories() {
    echo "--- 📁 Создаём директории ---"

    echo "/etc/init.d/"
    mkdir -p /etc/init.d/
    echo "/usr/bin"
    mkdir -p /usr/bin/
    echo "/usr/lib/lua/luci/controller"
    mkdir -p /usr/lib/lua/luci/controller/
    echo "/usr/lib/lua/luci/view"
    mkdir -p /usr/lib/lua/luci/view/
    echo "/etc/wifistats"
    mkdir -p /etc/wifistats/

    echo "--- ✅ Директории созданы ---"
}

try_download_file() {
    local file="$1"
    local dest="$2"

    wget -q -O "$dest" "$file" >/dev/null 2>&1 && return 0

    return 1
}

download_file() {
    local file_path="$1"
    local dest="$2"

    local status=0

    echo "🔃 Скачиваем файл: $1"
    if try_download_file "${REPOSITORY}/${BRANCH}/${file_path}" "$dest"; then
        status=1
    fi

    if [ "$status" -ne 1 ]; then
        echo "❌ Не удалось скачать файл ${file_path}. Попробуйте повторить установку позже." >&2
        exit 1
    fi
}

download_project_files() {
    echo "--- ⚙️ Скачиваем файлы проекта ---"

    download_file "root/etc/init.d/wifistats" "/etc/init.d/wifistats"
    download_file "root/usr/bin/wifistats" "/usr/bin/wifistats"
    download_file "root/usr/lib/lua/luci/controller/wifistats.lua" "/usr/lib/lua/luci/controller/wifistats.lua"
    download_file "root/usr/lib/lua/luci/view/wifistats_today.htm" "/usr/lib/lua/luci/view/wifistats_today.htm"
    download_file "root/usr/lib/lua/luci/view/wifistats_yesterday.htm" "/usr/lib/lua/luci/view/wifistats_yesterday.htm"
    download_file "root/usr/lib/lua/luci/view/wifistats_two_days_ago.htm" "/usr/lib/lua/luci/view/wifistats_two_days_ago.htm"

    echo "--- ✅ Файлы проекта скачаны ---"
}

start_daemon() {
    echo "--- 🛠️ Проводим последние приготовления ---"

    echo "📕 Регулируем права..."
    chmod 755 /etc/init.d/wifistats
    chmod 755 /usr/bin/wifistats
    chmod 644 /etc/wifistats

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
    echo "Мониторинг доступен на Статус -> Статистика Wi-Fi"

    rm -f /tmp/wifistats-install.sh 2>/dev/null || true
}

install_project