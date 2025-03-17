const fs = require("fs");
const path = require("path");

// Utility function to escape HTML
function escapeHTML(str) {
    return str.replace(/[&<>"']/g, tag => {
        const chars = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' };
        return chars[tag] || tag;
    });
}

const modulesTxtPath = path.join(__dirname, "..", "modules.txt");
if (!fs.existsSync(modulesTxtPath)) process.exit(0);

const raw = fs.readFileSync(modulesTxtPath, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);
const data = [];
for (let i = 0; i < lines.length; i += 3) {
    const n = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "Untitled";
    const a = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "Unknown";
    const d = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "None";
    data.push({ name: escapeHTML(n), author: escapeHTML(a), desc: escapeHTML(d) });
}

const docsDir = path.join(__dirname);
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);

// Create a downloads folder within the docs folder to store ZIP files.
const downloadsDir = path.join(docsDir, "downloads");
if (!fs.existsSync(downloadsDir)) fs.mkdirSync(downloadsDir);

// Copy repository.zip if exists
const repoZipSrc = path.join(__dirname, "..", "repository.zip");
let repoZipDest = null;
if (fs.existsSync(repoZipSrc)) {
    repoZipDest = path.join(downloadsDir, "repository.zip");
    fs.copyFileSync(repoZipSrc, repoZipDest);
}

// Generate index.html
let index = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Modules</title>
</head>
<body>
  <h1>Modules</h1>
  <ul>`;
data.forEach(m => {
    const folder = m.name.replace(/\s+/g, "");
    index += `<li><a href="module-${folder}.html">${m.name}</a></li>`;
});
index += `</ul>
</body>
</html>`;
fs.writeFileSync(path.join(docsDir, "index.html"), index);

// Generate detail pages and copy each module ZIP
data.forEach(m => {
    const folder = m.name.replace(/\s+/g, "");
    const detailFile = `module-${folder}.html`;
    let html = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${m.name}</title>
</head>
<body>
  <a href="index.html">Back</a>
  <h2>${m.name}</h2>
  <p>by ${m.author}</p>
  <p>${m.desc}</p>`;

    // Source path for the module ZIP
    const moduleZipSrc = path.join(__dirname, "..", "modules", folder + ".zip");
    let moduleZipDest = null;
    if (fs.existsSync(moduleZipSrc)) {
        // Copy the ZIP file to the downloads folder.
        moduleZipDest = path.join(downloadsDir, folder + ".zip");
        fs.copyFileSync(moduleZipSrc, moduleZipDest);
        // Link to the ZIP file in the downloads folder.
        html += `<p><a href="downloads/${folder}.zip" download>Download Module ZIP</a></p>`;
    } else {
        html += `<p>No Module ZIP found</p>`;
    }

    if (repoZipDest) {
        html += `<p><a href="downloads/repository.zip" download>Download Full Repo ZIP</a></p>`;
    } else {
        html += `<p>No Repo ZIP found</p>`;
    }
    html += `</body>
</html>`;
    fs.writeFileSync(path.join(docsDir, detailFile), html);
});

// Optionally, remove the modules.txt file if no longer needed.
fs.unlinkSync(modulesTxtPath);
