const fs = require("fs");
const path = require("path");

function escapeHTML(str) {
    return str.replace(/[&<>"']/g, tag => {
        const chars = { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" };
        return chars[tag] || tag;
    });
}

const modulesTxtPath = path.join(__dirname, "..", "modules.txt");
if (!fs.existsSync(modulesTxtPath)) {
    console.log("No modules.txt found, exiting docs build.");
    process.exit(0);
}

// Read modules.txt lines
const raw = fs.readFileSync(modulesTxtPath, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);

// Parse them in triplets: Name = "X", Author = "Y", Description = "Z"
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

// Put zips directly into docs/Downloads
const downloadsDir = path.join(docsDir, "Downloads");
if (!fs.existsSync(downloadsDir)) fs.mkdirSync(downloadsDir);

// Build the index.html
let indexHtml =
    `<!DOCTYPE html>
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
    indexHtml += `  <li><a href="module-${folder}.html">${mod.name}</a></li>\n`;
});
indexHtml +=
    `</ul>
</body>
</html>
`;
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml.trim());

// Build each module detail page & copy .zip if it exists
data.forEach(mod => {
    const folder = mod.name.replace(/\s+/g, "");
    const detailFile = `module-${folder}.html`;

    let html =
        `<!DOCTYPE html>
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
    // Where the workflow downloaded artifact zips (now inside docs/downloaded_zips)
    const moduleZipSrc = path.join(__dirname, "downloaded_zips", folder + ".zip");
    if (fs.existsSync(moduleZipSrc)) {
        // Copy to docs/Downloads
        const moduleZipDest = path.join(downloadsDir, folder + ".zip");
        fs.copyFileSync(moduleZipSrc, moduleZipDest);
        // Link points to "Downloads/folder.zip"
        html += `  <p><a href="Downloads/${folder}.zip" download>Download Module ZIP</a></p>\n`;
    } else {
        html += `  <p>No Module ZIP found</p>\n`;
    }

    html +=
        `</body>
</html>
`;
    fs.writeFileSync(path.join(docsDir, detailFile), html.trim());
});

// Remove modules.txt so it won't remain in docs
fs.unlinkSync(modulesTxtPath);
