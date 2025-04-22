# zabbix-script-auto-monitor-service
## Cai dat zabbix-agent link:
https://www.zabbix.com/download

##Tao thư mục script
mkdir /etc/zabbix/scripts/
mv 

## Tao file cau hinh rieng cho UserParameter
cat <<EOF > /etc/zabbix/zabbix_agentd.d/auto_service_monitoring.conf
UserParameter=service.discovery,/etc/zabbix/scripts/discover_services.sh discover
UserParameter=service.status[*],/etc/zabbix/scripts/discover_services.sh status \$1
EOF

# Khoi dong lai Zabbix Agent de ap dung cau hinh moi
systemctl restart zabbix-agent

# Kiem tra trang thai Zabbix Agent
systemctl status zabbix-agent
