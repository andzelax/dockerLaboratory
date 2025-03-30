const http = require("http");
const os = require("os");

const interfaces = os.networkInterfaces();
let ip = "unknown";

for (const key in interfaces) {
    for (const iface of interfaces[key]) {
        if (!iface.internal && iface.family === "IPv4") {
            ip = iface.address;
            break;
        }
    }
}

const server = http.createServer((req, res) => {
    res.writeHead(200, {"Content-Type": "text/html"});
    res.end(`<html><body><h1>Wersja: ${process.env.VERSION}</h1><p>IP: ${ip}</p><p>Host: ${os.hostname()}</p></body></html>`);
});

server.listen(8080);
