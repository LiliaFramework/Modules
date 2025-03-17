const fs = require("fs");
const path = require("path");

function escapeHTML(str) {
    return str.replace(/[&<>"']/g, tag => {
        const chars = {
            "&": "&amp;",
            "<": "&lt;",
            ">": "&gt;",
            '"': "&quot;",
            "'": "&#39;"
        };
        return chars[tag] || tag;
    });
}

const modulesTxtPath = path.join(__dirname, "..", "modules.txt");
if (!fs.existsSync(modulesTxtPath)) {
    // If there's no modules.txt, just exit.
    process.exit(0);
}

const raw = fs.readFileSync(modulesTxtPath, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);

const data = [];
for (let i = 0; i < lines.length; i += 3) {
    const n = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "Untitled";
    const a = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "Unknown";
    const d = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "None";
    data.push({
        name: escapeHTML(n),
        author: escapeHTML(a),
        desc: escapeHTML(d)
    });
}

const docsDir = path.join(__dirname);
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);
if (!fs.existsSync(path.join(docsDir, "downloads"))) {

const downloadsBase = path.join(docsDir, "downloads");
const downloadsDir = path.join(downloadsBase, "modules");

if (!fs.existsSync(downloadsBase)) {
    fs.mkdirSync(downloadsBase);
}
if (!fs.existsSync(downloadsDir)) {
    fs.mkdirSync(downloadsDir);
}

// Build index page
let index = '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Modules</title></head><body><h1>Modules</h1><ul>';
data.forEach(mod => {
    const folder = mod.name.replace(/\s+/g, "");
    index += `<li><a href="module-${folder}.html">${mod.name}</a></li>`;
});
index += "</ul></body></html>";
fs.writeFileSync(path.join(docsDir, "index.html"), index);

// Build detail pages + copy zips
data.forEach(mod => {
    const folder = mod.name.replace(/\s+/g, "");
    const detailFile = `module-${folder}.html`;
    let html = `<!DOCTYPE html><html><head><meta charset="UTF-8"><title>${mod.name}</title></head><body>`;
    html += `<a href="index.html">Back</a><h2>${mod.name}</h2><p>by ${mod.author}</p><p>${mod.desc}</p>`;

    // path to artifact-downloaded ZIP
    const moduleZipSrc = path.join(__dirname, "downloaded_zips", folder + ".zip");
    if (fs.existsSync(moduleZipSrc)) {
        // copy the zip to docs/downloads/modules
        const moduleZipDest = path.join(downloadsDir, folder + ".zip");
        fs.copyFileSync(moduleZipSrc, moduleZipDest);

        // Link to the copied zip
        html += `<p><a href="downloads/modules/${folder}.zip" download>Download Module ZIP</a></p>`;
    } else {
        html += "<p>No Module ZIP found</p>";
    }
    html += "</body></html>";

    fs.writeFileSync(path.join(docsDir, detailFile), html);
});

// Remove modules.txt so it doesn't stay in docs
fs.unlinkSync(modulesTxtPath);
