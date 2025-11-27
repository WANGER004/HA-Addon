# Ha-WebDAV-Mount 插件说明

本插件可以通过 UI 将 WebDAV 存储挂载到 Home Assistant 系统文件目录。

## 使用说明

1. 安装插件
2. 启动插件
3. 打开浏览器访问 `http://HA_IP:8127`
4. 输入 WebDAV 地址、用户名和密码
5. 点击“挂载”或“卸载”
6. 状态会实时显示

## 注意事项

- 插件需要开启特权模式（privileged: true）
- 默认挂载路径 `/mnt/webdav` 可在配置中修改
- 如果挂载失败，请确认 WebDAV 地址和凭证正确
