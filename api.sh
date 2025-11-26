#!/usr/bin/env bash
# 简易 HTTP API 服务，监听 8127
# 提供挂载、卸载和状态查询接口

CONFIG_PATH=/data/options.json

# 读取配置
MOUNT_PATH=$(jq -r '.mount_path' $CONFIG_PATH)
WEBDAV_URL=$(jq -r '.webdav_url' $CONFIG_PATH)
USERNAME=$(jq -r '.username' $CONFIG_PATH)
PASSWORD=$(jq -r '.password' $CONFIG_PATH)

# 创建挂载目录
mkdir -p $MOUNT_PATH

# 无限循环监听请求
while true; do
  { read request
    if echo "$request" | grep -q GET.*status; then
      # 查询挂载状态
      mountpoint -q $MOUNT_PATH && echo -e "HTTP/1.1 200 OK\r\n\r\nmounted" || echo -e "HTTP/1.1 200 OK\r\n\r\nnot mounted"
    elif echo "$request" | grep -q GET.*mount; then
      # 写入用户名密码并挂载
      echo "${WEBDAV_URL} ${USERNAME} ${PASSWORD}" > /etc/davfs2/secrets
      chmod 600 /etc/davfs2/secrets
      mount -t davfs $WEBDAV_URL $MOUNT_PATH
      echo -e "HTTP/1.1 200 OK\r\n\r\nmounted"
    elif echo "$request" | grep -q GET.*unmount; then
      # 卸载挂载
      umount $MOUNT_PATH
      echo -e "HTTP/1.1 200 OK\r\n\r\nunmounted"
    else
      # 默认响应
      echo -e "HTTP/1.1 200 OK\r\n\r\nok"
    fi
  } | nc -l -p 8127 -q 1   # 监听端口改为 8127
done
