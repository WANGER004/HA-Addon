function mount() {
    let data = {
        url: document.getElementById("url").value,
        username: document.getElementById("username").value,
        password: document.getElementById("password").value
    };

    fetch("/api/mount", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    }).then(res => res.json()).then(d => {
        document.getElementById("status").innerText = d.status;
    });
}

function unmount() {
    fetch("/api/unmount", { method: "POST" })
        .then(res => res.json())
        .then(d => {
            document.getElementById("status").innerText = d.status;
        });
}
