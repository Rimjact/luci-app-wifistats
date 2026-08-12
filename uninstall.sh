#!/bin/sh

cleanup_services() {
    echo "--- 🛠️ Готовимся удалять ---"

    echo "👾 Запускаем демонов обратно..."
    /etc/init.d/wifistats stop >/dev/null 2>&1 || true
    /etc/init.d/wifistats disable >/dev/null 2>&1 || true
    /etc/init.d/uhttpd restart >/dev/null 2>&1 || true

    echo "--- ✅ Приготовления к удалению закончены ---"
}

rmf() {
    rm -f "$@" 2>/dev/null || true
}

delete_project_files() {
    echo "--- ⚙️ Удаляем файлы проекта ---"

    rmf /etc/init.d/wifistats \
        /usr/bin/wifistats \
        /usr/lib/lua/luci/controller/wifistats.lua \
        /usr/lib/lua/luci/view/wifistats_today.htm \
        /usr/lib/lua/luci/view/wifistats_yesterday.htm \
        /usr/lib/lua/luci/view/wifistats_two_days_ago.htm

    echo "--- ✅ Файлы проекта удалены ---"
}

uninstall_project() {
    echo "=== ▶️ Начало удаления Wi-Fi Stats ==="

    cleanup_services
    delete_project_files

    echo "=== 🎈 Wi-Fi Stats удалён ==="
    echo "Мониторинг более недоступен."
    echo "Удалите зависимости вручную, если они не используются."
    echo "Файл состояния за текущий день остался по пути /etc/wifistats/state.json"

    rmf /tmp/wifistats-uninstall.sh
}

uninstall_project