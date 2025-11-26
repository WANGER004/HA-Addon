# 使用官方的 Alpine Linux 3.19 镜像作为基础
FROM alpine:3.19

# 维护者信息
LABEL maintainer="wanger004"

# 设置工作目录
WORKDIR /app

# 更新包索引并安装所需软件
RUN apk update && \
    apk add --no-cache \
        bash \
        nginx \
        davfs2 \
        jq \
        curl \
        netcat-openbsd && \
    rm -rf /var/cache/apk/*

# 将脚本和网页复制到容器中
COPY run.sh .
COPY api.sh .
COPY web /var/www/html/

# 给脚本添加可执行权限
RUN chmod +x run.sh api.sh

# 暴露 8127 端口（直接访问 UI 和 API）
EXPOSE 8127

# 启动容器时执行 run.sh
CMD ["/app/run.sh"]
