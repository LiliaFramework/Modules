const fs = require("fs");
const path = require("path");
const modulesTxtPath = path.join(__dirname, "..", "modules.txt");
if (!fs.existsSync(modulesTxtPath)) process.exit(0);
const raw = fs.readFileSync(modulesTxtPath, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);
const data = [];
for (let i = 0; i < lines.length; i += 3) {
    const n = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "Untitled";
    const a = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "Unknown";
    const d = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "None";
    data.push({ name: n, author: a, desc: d });
}
const docsDir = path.join(__dirname);
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);
let index = `<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Modules</title></head><body><h1>Modules</h1><ul>`;
data.forEach(m => {
    const folder = m.name.replace(/\s+/g, "");
    index += `<li><a href="module-${folder}.html">${m.name}</a></li>`;
});
index += `</ul></body></html>`;
fs.writeFileSync(path.join(docsDir, "index.html"), index);
data.forEach(m => {
    const folder = m.name.replace(/\s+/g, "");
    const detailFile = `module-${folder}.html`;
    let html = `<!DOCTYPE html><html><head><meta charset="UTF-8"><title>${m.name}</title></head><body><a href="index.html">Back</a><h2>${m.name}</h2><p>by ${m.author}</p><p>${m.desc}</p>`;
    const zipPath = path.join(__dirname, "..", "modules", folder + ".zip");
    if (fs.existsSync(zipPath)) {
        html += `<p><a href="../modules/${folder}.zip" download>Download Module ZIP</a></p>`;
    } else {
        html += `<p>No Module ZIP found</p>`;
    }
    const repoZipPath = path.join(__dirname, "..", "repository.zip");
    if (fs.existsSync(repoZipPath)) {
        html += `<p><a href="../repository.zip" download>Download Full Repo ZIP</a></p>`;
    } else {
        html += `<p>No Repo ZIP found</p>`;
    }
    html += `</body></html>`;
    fs.writeFileSync(path.join(docsDir, detailFile), html);
});
fs.unlinkSync(modulesTxtPath);
