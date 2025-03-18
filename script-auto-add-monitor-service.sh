#!/bin/bash

# Kiểm tra quyền root
if [[ $EUID -ne 0 ]]; then
   echo "Vui lòng chạy script với quyền root: sudo ./create_zabbix_config.sh"
   exit 1
fi

echo "🚀 Bắt đầu tạo cấu hình UserParameter cho Zabbix Agent..."

# Kiểm tra xem Zabbix Agent đã được cài chưa
if ! command -v zabbix_agentd &> /dev/null
then
    echo "📦 Zabbix Agent chưa được cài đặt, bắt đầu cài đặt..."
    apt update && apt install -y zabbix-agent
else
    echo "✅ Zabbix Agent đã được cài đặt."
fi

# Tạo thư mục nếu chưa có
mkdir -p /etc/zabbix/zabbix_agentd.d

# Tạo file cấu hình riêng cho UserParameter
cat <<EOF > /etc/zabbix/zabbix_agentd.d/auto_service_monitoring.conf
### Zabbix Auto Service Monitoring
UserParameter=service.discovery,/etc/zabbix/scripts/discover_services.sh discover
UserParameter=service.status[*],/etc/zabbix/scripts/discover_services.sh status \$1
EOF

echo "✅ Cấu hình UserParameter đã được tạo thành công!"

# Khởi động lại Zabbix Agent để áp dụng cấu hình mới
echo "♻️ Khởi động lại Zabbix Agent..."
systemctl restart zabbix-agent

# Kiểm tra trạng thái Zabbix Agent
systemctl status zabbix-agent --no-pager

echo "✅ Zabbix Agent đã được khởi động lại thành công với cấu hình mới."
