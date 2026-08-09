module("luci.controller.wifistats", package.seeall)

function index()
    entry(
        {"admin", "status", "wifistats"},
        template("wifistats"),
        _("Статистика Wi-Fi"),
        30
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
