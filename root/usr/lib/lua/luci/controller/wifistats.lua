module("luci.controller.wifistats", package.seeall)

function index()
    entry(
        {"admin", "status", "wifistats"},
        firstchild(),
        _("Статистика Wi-Fi"),
        30
    ).dependent = false


    entry(
        {"admin", "status", "wifistats", "today"},
        template("wifistats_today"),
        _("Сегодня"),
        1
    )

    entry(
        {"admin", "status", "wifistats", "yesterday"},
        template("wifistats_yesterday"),
        _("Вчера"),
        2
    )

    entry(
        {"admin", "status", "wifistats", "two_days_ago"},
        template("wifistats_two_days_ago"),
        _("Позавчера"),
        3
    )

    entry(
        {"admin", "status", "wifistats", "data"},
        call("data"),
        nil
    ).leaf = true
end

function data()
    local http = require("luci.http")

    local file = io.open("/etc/wifistats/state.json", "r")
    if not file then
        http.status(404, "Not Found")
        return
    end

    local content = file:read("*a")
    file:close()

    http.prepare_content("application/json")
    http.write(content)
end
