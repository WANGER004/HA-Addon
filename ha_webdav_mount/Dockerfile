ARG BUILD_FROM
FROM $BUILD_FROM

# 安装 Python3、Flask、davfs2、jq 等
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-flask \
    bash \
    curl \
    jq \
    davfs2

# 创建目录
RUN mkdir -p /mnt/webdav /web

# 拷贝前端文件
COPY web /web

# 拷贝 rootfs，包含 s6 服务脚本
COPY rootfs /rootfs

# 赋予 rootfs 脚本权限
RUN chmod -R +x /rootfs

# 设置工作目录
WORKDIR /rootfs
