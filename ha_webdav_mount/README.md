# HA WebDAV挂载（Home Assistant Add-on）

这是一个用于 **Home Assistant** 的轻量级 **WebDAV 挂载插件（Add-on）**。  
通过本插件，你可以将任意 WebDAV 存储挂载到 Home Assistant 系统内部，用作媒体库、备份目录、自定义存储或供其他插件调用。

---

## ✨ 功能特点

- 📁 将 WebDAV 服务器挂载为本地文件目录  
- 🔐 支持用户名与密码认证  
- 🔄 支持开机自动挂载  
- 🔧 通过 `config.json` 简单配置即可使用  
- 🧩 可与其他 Add-on、脚本、集成配合使用  
- 🪶 体积小、依赖少，稳定可靠

---

## 📦 安装方法

### **方式一：通过 Add-on Store 添加仓库**

1. 打开：**设置 → 插件（Add-ons） → 插件商店（Add-on Store）**
2. 点击右上角 **“添加仓库（Repositories）”**
3. 填入此仓库地址（你的 GitHub 地址）
4. 在列表中找到 **HA WebDAV挂载**
5. 安装插件
6. 配置 WebDAV 地址与账号
7. 启动插件即可使用

---

## ⚙️ 配置示例

在插件的 **Configuration** 中填写：

```yaml
webdav_url: "https://example.com/dav/"
username: "你的用户名"
password: "你的密码"
mount_path: "/mnt/webdav"
options: "rw"
```



## 📂 挂载路径说明

插件运行后，会将 WebDAV 存储挂载到：

/mnt/webdav


你可以将其用于：

- Home Assistant 媒体浏览器（Media Browser）
- 备份路径
- 自定义组件存储
- Add-on 文件读写
- 自动化脚本文件读写
- Nginx / Frigate 等插件共享文件

## 🛠️ 工作原理

插件基于：

- Alpine Linux
- `davfs2` WebDAV 客户端

通过 WebDAV 协议将远程存储挂载到指定路径，并保持挂载状态。

## 📜 开源协议

本项目采用 **MIT License**。

## 🤝 贡献

欢迎提交 PR 或建议，持续改进插件功能！

