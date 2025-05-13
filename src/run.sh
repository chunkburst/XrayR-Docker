#!/bin/bash

XRAYR_DIR="/root/Xray/"
XRAYR_EXEC="${XRAYR_DIR}/XrayR"
XRAYR_CONFIG="${XRAYR_DIR}/config.yml"
SERVICE_NAME="xrayr.service"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}"

echo "开始设置 XrayR 守护进程..."

# 检查程序文件是否存在
if [[ ! -f "$XRAYR_EXEC" || ! -f "$XRAYR_CONFIG" ]]; then
    echo "错误：找不到 XrayR 可执行文件在 ${XRAYR_EXEC} or 无Config (${$XRAYR_CONFIG})"
    echo "请确保文件存在 && 有执行权限"
    exit 1
fi

echo "创建 systemd: ${SERVICE_FILE}"
cat <<EOF > ${SERVICE_FILE}
[Unit]
Description=XrayR Service
After=network.target

[Service]
ExecStart=${XRAYR_EXEC} --config ${XRAYR_CONFIG}
WorkingDirectory=${XRAYR_DIR}
Type=simple
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

echo "正在重新加载 systemd 配置..."
systemctl daemon-reload

echo "正在启用 XrayR 服务开机自启..."
systemctl enable ${SERVICE_NAME}

echo "正在启动 XrayR 服务..."
systemctl start ${SERVICE_NAME}

echo "检查服务状态..."
systemctl status ${SERVICE_NAME} --no-pager

echo "XrayR 守护进程设置完成"
echo "1. 'systemctl status ${SERVICE_NAME}' 查看状态"
echo "2. 'systemctl stop ${SERVICE_NAME}' 停止服务"
echo "3 . 'systemctl restart ${SERVICE_NAME}' 重启服务"
echo "4. 'journalctl -u ${SERVICE_NAME} -f' 查看日志"
