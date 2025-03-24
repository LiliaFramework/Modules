const fs = require("fs");
const path = require("path");

function escapeHTML(str = "") {
  return str.replace(/[&<>"']/g, t => ({
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;"
  })[t] || t);
}

const jsonPath = path.join(__dirname, "..", "modules.json");
if (!fs.existsSync(jsonPath)) process.exit(0);

const data = JSON.parse(fs.readFileSync(jsonPath, "utf8")).map(mod => ({
  name: escapeHTML(mod.name),
  author: escapeHTML(mod.author),
  desc: escapeHTML(mod.description),
  license: escapeHTML(mod.license || ""),
  version: escapeHTML(mod.version),
  published: escapeHTML(mod.published || "")
}));

const docsDir = __dirname;
const downloadsDir = path.join(docsDir, "Downloads");
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);
if (!fs.existsSync(downloadsDir)) fs.mkdirSync(downloadsDir);

const baseCSS = `...`; // your existing CSS/JS

let indexHtml = `
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Lilia Module Center</title>${baseCSS}</head>
<body>
<div class="top-bar"><a href="#">Home</a></div>
<div class="teal-bar">Lilia Module Center</div>
<div class="module-list">
`;

data.forEach(mod => {
  const id = mod.name.replace(/\s+/g, "");
  indexHtml += `
<div class="module-card">
  <div class="module-title">${mod.name}</div>
  <div class="module-author">by ${mod.author}</div>
  <div class="module-date">${mod.published}</div>
  <a href="module-${id}.html">View Details</a>
</div>`;
});

indexHtml += `
</div>
</body>
</html>`;
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml);

data.forEach(mod => {
  const id = mod.name.replace(/\s+/g, "");
  const zipName = `${id}.zip`;
  const downloadBtn = fs.existsSync(path.join(downloadsDir, zipName))
    ? `<a class="download-btn" href="Downloads/${zipName}" download>Download</a>`
    : "<p>No download found.</p>";

  const detailHtml = `
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>${mod.name}</title>${baseCSS}</head>
<body>
<div class="top-bar"><a href="index.html">Home</a></div>
<div class="teal-bar">Lilia Module Center</div>
<div class="detail-container">
  <div class="left-column">
    <div class="detail-header"><h1>${mod.name}</h1><div class="author">by ${mod.author}</div></div>
    <ul class="tabs">
      <li class="active" data-tab="desc-tab" onclick="switchTab('desc-tab')">Description</li>
      <li data-tab="lic-tab" onclick="switchTab('lic-tab')">License</li>
    </ul>
    <div class="tab-content">
      <div id="desc-tab" class="tab-section">${mod.desc}</div>
      <div id="lic-tab" class="tab-section" style="display:none">${mod.license}</div>
    </div>
  </div>
  <div class="right-column"><div class="download-box">${downloadBtn}</div></div>
</div>
</body>
</html>`;
  fs.writeFileSync(path.join(docsDir, `module-${id}.html`), detailHtml);
});
