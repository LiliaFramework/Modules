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
    console.log("No modules.txt found, exiting docs build.");
    process.exit(0);
}

const raw = fs.readFileSync(modulesTxtPath, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);

const data = [];
for (let i = 0; i < lines.length; i += 3) {
    const nameLine = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "Untitled";
    const authorLine = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "Unknown";
    const descLine = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "None";
    data.push({
        name: escapeHTML(nameLine),
        author: escapeHTML(authorLine),
        desc: escapeHTML(descLine)
    });
}

const docsDir = __dirname;
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);

const downloadsBase = path.join(docsDir, "downloads");
const downloadsDir = path.join(downloadsBase, "modules");
if (!fs.existsSync(downloadsBase)) fs.mkdirSync(downloadsBase);
if (!fs.existsSync(downloadsDir)) fs.mkdirSync(downloadsDir);

// Build index.html
let indexHtml = `
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modules</title>
</head>
<body>
    <h1>Modules</h1>
    <ul>
`;
data.forEach(mod => {
    const folder = mod.name.replace(/\s+/g, "");
    indexHtml += `        <li><a href="module-${folder}.html">${mod.name}</a></li>\n`;
});
indexHtml += `
    </ul>
</body>
</html>
`;
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml.trim());

// Build detail pages and copy the ZIP if it exists
data.forEach(mod => {
    const folder = mod.name.replace(/\s+/g, "");
    const detailFileName = `module-${folder}.html`;

    let detailHtml = `
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${mod.name}</title>
</head>
<body>
    <a href="index.html">Back</a>
    <h2>${mod.name}</h2>
    <p>by ${mod.author}</p>
    <p>${mod.desc}</p>
`;

    // The artifact-downloaded zips are stored here:
    const moduleZipSrc = path.join(__dirname, "downloaded_zips", folder + ".zip");
    if (fs.existsSync(moduleZipSrc)) {
        const moduleZipDest = path.join(downloadsDir, folder + ".zip");
        fs.copyFileSync(moduleZipSrc, moduleZipDest);

        detailHtml += `    <p><a href="downloads/modules/${folder}.zip" download>Download Module ZIP</a></p>\n`;
    } else {
        detailHtml += `    <p>No Module ZIP found</p>\n`;
    }

    detailHtml += `
</body>
</html>
`;
    fs.writeFileSync(path.join(docsDir, detailFileName), detailHtml.trim());
});

// Remove modules.txt (it's no longer needed)
fs.unlinkSync(modulesTxtPath);