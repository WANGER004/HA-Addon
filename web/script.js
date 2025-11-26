// 获取挂载状态并更新 UI
async function getStatus() {
  let res = await fetch('/api/status');
  let text = await res.text();
  document.getElementById('status').innerText = text;
}

// 挂载 WebDAV
async function mount() {
  await fetch('/api/mount');
  getStatus();
}

// 卸载 WebDAV
async function unmount() {
  await fetch('/api/unmount');
  getStatus();
}

// 每 2 秒自动刷新状态
setInterval(getStatus, 2000);

// 页面加载完成后立即刷新状态
window.onload = getStatus;
