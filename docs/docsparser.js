#!/usr/bin/env node
const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");

const modulesTxtPath = path.join(__dirname, "..", "modules.txt");
if (!fs.existsSync(modulesTxtPath)) process.exit(0);
const raw = fs.readFileSync(modulesTxtPath, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);
const modules = [];
for (let i = 0; i < lines.length; i += 3) {
    const n = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "Untitled";
    const a = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "Unknown";
    const d = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "None";
    modules.push({ name: n, author: a, desc: d });
}

const docsDir = path.join(__dirname);
const modulesDir = path.join(__dirname, "..", "modules");
if (!fs.existsSync(modulesDir)) fs.mkdirSync(modulesDir);

const indexFile = [];
indexFile.push(`<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Modules</title></head><body>`);
indexFile.push(`<h1>Modules</h1><ul>`);

modules.forEach(m => {
    const slug = m.name.replace(/\s+/g, "-").toLowerCase();
    indexFile.push(`<li><a href="module-${slug}.html">${m.name}</a></li>`);
});
indexFile.push(`</ul></body></html>`);

fs.writeFileSync(path.join(docsDir, "index.html"), indexFile.join("\n"));

modules.forEach(m => {
    const slug = m.name.replace(/\s+/g, "-").toLowerCase();
    let detail = `<!DOCTYPE html><html><head><meta charset="UTF-8"><title>${m.name}</title></head><body>`;
    detail += `<p><a href="index.html">Back</a></p>`;
    detail += `<h2>${m.name}</h2>`;
    detail += `<p>by ${m.author}</p>`;
    detail += `<p>${m.desc}</p>`;

    const moduleFolder = path.join(modulesDir, slug);
    const zipName = `${slug}.zip`;
    if (fs.existsSync(moduleFolder) && fs.lstatSync(moduleFolder).isDirectory()) {
        try {
            execSync(`zip -r ${zipName} ${slug}`, { cwd: modulesDir });
            fs.renameSync(
                path.join(modulesDir, zipName),
                path.join(docsDir, zipName)
            );
            detail += `<p><a href="${zipName}" download>Download ZIP</a></p>`;
        } catch (err) {
            detail += `<p>(No ZIP could be generated)</p>`;
        }
    } else {
        detail += `<p><a href="https://github.com/LiliaFramework/Modules/archive/refs/heads/main.zip">Download Repo ZIP</a></p>`;
    }

    detail += `</body></html>`;
    fs.writeFileSync(path.join(docsDir, `module-${slug}.html`), detail);
});

fs.unlinkSync(modulesTxtPath);
