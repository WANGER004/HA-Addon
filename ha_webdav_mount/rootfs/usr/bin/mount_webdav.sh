#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json

MOUNT_PATH=$(jq -r '.mount_path' "$CONFIG_PATH")
WEBDAV_URL=$(jq -r '.webdav_url' "$CONFIG_PATH")
USERNAME=$(jq -r '.username' "$CONFIG_PATH")
PASSWORD=$(jq -r '.password' "$CONFIG_PATH")

echo "[mount] Mount path: $MOUNT_PATH"
echo "[mount] URL: $WEBDAV_URL"

mkdir -p "$MOUNT_PATH"

# 写入 davfs2 密码
echo "$WEBDAV_URL $USERNAME $PASSWORD" > /etc/davfs2/secrets
chmod 600 /etc/davfs2/secrets

# 挂载
mount.davfs "$WEBDAV_URL" "$MOUNT_PATH" -o rw,uid=0,gid=0

echo "[mount] WebDAV mounted successfully!"

# 持续运行
while true; do sleep 300; done
