#!/bin/bash

# Kiem tra quyen root
if [[ $EUID -ne 0 ]]; then
   echo "Vui long chay script voi quyen root: sudo ./create_zabbix_config.sh"
   exit 1
fi

echo "🚀 Bat dau them cau hinh UserParameter vao Zabbix Agent..."

# Tao thu muc neu chua co
mkdir -p /etc/zabbix/zabbix_agentd.d

# Tao file cau hinh rieng cho UserParameter
cat <<EOF > /etc/zabbix/zabbix_agentd.d/auto_service_monitoring.conf
### Zabbix Auto Service Monitoring
UserParameter=service.discovery,/etc/zabbix/scripts/discover_services.sh discover
UserParameter=service.status[*],/etc/zabbix/scripts/discover_services.sh status \$1
EOF

echo "✅ Cau hinh UserParameter da duoc tao thanh cong!"

# Khoi dong lai Zabbix Agent de ap dung cau hinh moi
echo "♻️ Khoi dong lai Zabbix Agent..."
systemctl restart zabbix-agent

# Kiem tra trang thai Zabbix Agent
systemctl status zabbix-agent --no-pager

echo "✅ Zabbix Agent da duoc khoi dong lai thanh cong voi cau hinh moi."
