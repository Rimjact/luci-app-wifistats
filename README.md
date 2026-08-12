# Wi-Fi Stats
Simple Wi-Fi statistics app for OpenWrt. Display total devices connects count, traffic usage by last 3 days, and devices table by current day.

Простое приложение Wi-Fi статистика для OpenWrt. Показывает общее количество клиентов, использование трафика за последние три дня, а также таблицу устройств за текущий день.

---
## Featuers
- 3 pages - today, yesterday and two days ago;
- total unique devices counter by last 3 days;
- total TX/RX traffic usage by last 3 days;
- table with unique devices connections by today info: MAC, status, signal, first seen, last seen and last disconnect.
## Возможности
- 3 страницы - сегодня, вчера и позавчера;
- общее количество уникальных устройств за последние три дня;
- общее количество TX/RX трафика за последние три дня;
- таблица с уникальными устройствами за сегодня
---
## Installation (Установка)
Copy and paste commands below to your SSH terminal and press Enter.
Скопируйте и вставьте команды ниже в ваш SSH терминал, после чего нажмите Enter.
```sh
wget -O /tmp/wifistats-install.sh https://raw.githubusercontent.com/Rimjact/luci-app-wifistats/main/install.sh
chmod +x /tmp/wifistats-install.sh
/tmp/wifistats-install.sh
```
After install go to Status -> Wi-Fi Stats at LuCI.

## Uninstallation (Удаление)
Copy and paste commands below to your SSH terminal and press Enter.
Скопируйте и вставьте команды ниже в ваш SSH терминал, после чего нажмите Enter.
```sh
wget -O /tmp/wifistats-uninstall.sh https://raw.githubusercontent.com/Rimjact/luci-app-wifistats/main/uninstall.sh
chmod +x /tmp/wifistats-uninstall.sh
/tmp/wifistats-uninstall.sh
```
---
## To-Do
- more stats (больше статистики);
- install by .ipk packet (установка засчёт .ipk пакета);
- fixes.