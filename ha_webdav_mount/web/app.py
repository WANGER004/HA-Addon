from flask import Flask, request, jsonify, send_from_directory
import os
import subprocess

# 指定前端静态文件目录
app = Flask(__name__, static_folder="/web", static_url_path="")

# -------------------------
# UI 页面路由
# -------------------------
@app.route("/")
def index():
    return send_from_directory("/web", "index.html")


# -------------------------
# WebDAV挂载
# -------------------------
@app.route("/api/mount", methods=["POST"])
def api_mount():
    data = request.json
    url = data.get("url")
    username = data.get("username")
    password = data.get("password")

    if not url:
        return jsonify({"status": "error", "msg": "URL不能为空"})

    # 创建凭据
    os.makedirs("/root/.davfs2", exist_ok=True)
    with open("/root/.davfs2/secrets", "w") as f:
        f.write(f"{url} {username} {password}\n")

    # 执行挂载
    cmd = ["mount", "-t", "davfs", url, "/mnt/webdav"]
    try:
        subprocess.check_output(cmd, stderr=subprocess.STDOUT)
        return jsonify({"status": "ok", "msg": "挂载成功"})
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "msg": e.output.decode()})


# -------------------------
# WebDAV 卸载
# -------------------------
@app.route("/api/unmount", methods=["POST"])
def api_unmount():
    cmd = ["umount", "/mnt/webdav"]
    try:
        subprocess.check_output(cmd, stderr=subprocess.STDOUT)
        return jsonify({"status": "ok", "msg": "卸载成功"})
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "msg": e.output.decode()})


# -------------------------
# 运行
# -------------------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
