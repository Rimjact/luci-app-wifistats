# Wi-Fi Stats
Simple Wi-Fi statistics app for OpenWrt. Display total devices connects count, traffic usage and devices table by current day.
---
## Featuers
- Current date;
- Total unique devices counter by current day;
- Total RX/TX traffic usage by current day;
- Table with unique devices connections info: MAC, status, signal, first seen, last seen and last disconnect.
---
## Installation
Copy and paste commands below to your SSH terminal.
```sh
wget -O /tmp/wifistats-install.sh https://raw.githubusercontent.com/Rimjact/luci-app-wifistats/main/install.sh
chmod +x /tmp/wifistats-install.sh
/tmp/wifistats-install.sh
```
## Uninstallation
Copy and paste commands below to your SSH terminal.
```sh
wget -O /tmp/wifistats-uninstall.sh https://raw.githubusercontent.com/Rimjact/luci-app-wifistats/main/uninstall.sh
chmod +x /tmp/wifistats-uninstall.sh
/tmp/wifistats-uninstall.sh
```
---
## To-Do
- More stats;
- Install by .ipk packet;
- Fixes.