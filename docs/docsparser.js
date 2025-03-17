const fs = require("fs");
const path = require("path");
const p = path.join(__dirname, "modules.txt");
if (!fs.existsSync(p)) process.exit(0);
const raw = fs.readFileSync(p, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);
const modules = [];
for (let i = 0; i < lines.length; i += 3) {
    const n = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "Untitled";
    const a = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "Unknown";
    const d = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "None";
    modules.push({ name: n, author: a, desc: d });
}
const docsDir = path.join(__dirname, "docs");
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);
let index = `<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Modules</title></head><body><h1>Modules</h1><ul>`;
modules.forEach(m => {
    const slug = m.name.replace(/\s+/g, "-").toLowerCase();
    index += `<li><a href="module-${slug}.html">${m.name}</a></li>`;
});
index += `</ul></body></html>`;
fs.writeFileSync(path.join(docsDir, "index.html"), index);
modules.forEach(m => {
    const slug = m.name.replace(/\s+/g, "-").toLowerCase();
    const detail = `<!DOCTYPE html><html><head><meta charset="UTF-8"><title>${m.name}</title></head><body><a href="index.html">Back</a><h2>${m.name}</h2><p>by ${m.author}</p><p>${m.desc}</p><a href="https://github.com/USER/REPO/archive/refs/heads/main.zip">Download ZIP</a></body></html>`;
    fs.writeFileSync(path.join(docsDir, `module-${slug}.html`), detail);
});
fs.unlinkSync(p);
