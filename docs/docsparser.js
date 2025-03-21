const fs = require("fs");
const path = require("path");

function escapeHTML(str) {
  return str.replace(/[&<>"']/g, t => {
    const c = {
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      '"': "&quot;",
      "'": "&#39;"
    };
    return c[t] || t;
  });
}

const modulesTxtPath = path.join(__dirname, "..", "modules.txt");
if (!fs.existsSync(modulesTxtPath)) process.exit(0);

const raw = fs.readFileSync(modulesTxtPath, "utf8");
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);
const data = [];
for (let i = 0; i < lines.length; i += 8) {
  const name = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "";
  const author = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "";
  const desc = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "";
  const options = lines[i + 3]?.match(/^Options\s*=\s*"(.*)"$/)?.[1] || "";
  const license = lines[i + 4]?.match(/^License\s*=\s*"(.*)"$/)?.[1] || "";
  const schema = lines[i + 5]?.match(/^Schema\s*=\s*"(.*)"$/)?.[1] || "";
  const lastUpdated = lines[i + 6]?.match(/^LastUpdated\s*=\s*"(.*)"$/)?.[1] || "";
  const published = lines[i + 7]?.match(/^Published\s*=\s*"(.*)"$/)?.[1] || "";
  data.push({
    name: escapeHTML(name),
    author: escapeHTML(author),
    desc: escapeHTML(desc),
    options: escapeHTML(options),
    license: escapeHTML(license),
    schema: escapeHTML(schema),
    lastUpdated: escapeHTML(lastUpdated),
    published: escapeHTML(published)
  });
}

const docsDir = __dirname;
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);
const downloadsDir = path.join(docsDir, "Downloads");
if (!fs.existsSync(downloadsDir)) fs.mkdirSync(downloadsDir);

const baseCSS = `
<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
body {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  background-color: #f6f6f6;
  color: #333;
}
.top-bar {
  background-color: #2a2a2a;
  padding: 8px 16px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}
.top-bar a {
  color: #fff;
  text-decoration: none;
  margin-left: 16px;
}
.top-bar a:hover {
  text-decoration: underline;
}
.teal-bar {
  background-color: rgb(37,116,108);
  padding: 16px;
  color: #fff;
  font-size: 1.3rem;
  font-weight: bold;
}
.module-list {
  max-width: 1200px;
  margin: 24px auto;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  padding: 0 20px;
}
.module-card {
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.2);
  padding: 16px;
  display: flex;
  flex-direction: column;
  min-height: 100px;
}
.module-title {
  font-size: 1.2rem;
  color: #444;
  margin-bottom: 4px;
}
.module-author {
  font-style: italic;
  color: #666;
  margin-bottom: 6px;
}
.module-date {
  font-size: 0.9rem;
  color: #999;
  margin-top: auto;
  text-align: right;
}
.module-card a {
  text-decoration: none;
  color: rgb(37,116,108);
  font-weight: bold;
}
.module-card a:hover {
  text-decoration: underline;
}
.detail-container {
  max-width: 1200px;
  margin: 20px auto;
  display: flex;
  gap: 20px;
  padding: 0 20px 40px;
}
.left-column {
  flex: 2;
}
.detail-header h1 {
  font-size: 1.8rem;
  color: #444;
  font-weight: normal;
  margin-bottom: 0;
}
.detail-header .author {
  margin-top: 4px;
  font-size: 1rem;
  color: #666;
}
.tabs {
  display: flex;
  list-style: none;
  padding: 0;
  margin: 20px 0 0;
  border-bottom: 1px solid #eee;
}
.tabs li {
  margin-right: 20px;
  padding-bottom: 8px;
  cursor: pointer;
  color: rgb(37,116,108);
}
.tabs li.active {
  font-weight: bold;
  border-bottom: 2px solid rgb(37,116,108);
}
.tab-content {
  background: #fff;
  margin-top: 8px;
  border-radius: 4px;
  padding: 16px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.2);
}
.right-column {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.download-box {
  background: #fff;
  padding: 16px;
  text-align: center;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.2);
}
.download-btn {
  display: block;
  width: 100%;
  padding: 16px 24px;
  background-color: rgb(37,116,108);
  color: #fff;
  text-decoration: none;
  border-radius: 4px;
  font-weight: bold;
  text-align: center;
  font-size: 1rem;
}
.download-btn:hover {
  opacity: 0.9;
}
</style>
<script>
function switchTab(t){
  var sections = document.querySelectorAll(".tab-section");
  var tabs = document.querySelectorAll(".tabs li");
  sections.forEach(s => {
    s.style.display = (s.id === t) ? "block" : "none";
  });
  tabs.forEach(a => {
    a.classList.toggle("active", a.getAttribute("data-tab") === t);
  });
}
</script>
`;

let indexHtml = `
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lilia Module Center</title>
${baseCSS}
</head>
<body>
<div class="top-bar">
<a href="#">Home</a>
</div>
<div class="teal-bar">Lilia Module Center</div>
<div class="module-list">
`;

data.forEach(mod => {
  const folder = mod.name.replace(/\s+/g, "");
  indexHtml += `
<div class="module-card">
<div class="module-title">${mod.name}</div>
<div class="module-author">by ${mod.author}</div>
<div class="module-date">${mod.published}</div>
<a href="module-${folder}.html">View Details</a>
</div>
`;
});

indexHtml += `
</div>
</body>
</html>
`;
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml);

data.forEach(mod => {
  const folder = mod.name.replace(/\s+/g, "");
  const detailFile = `module-${folder}.html`;
  let files = [];
  try {
    files = fs.readdirSync(downloadsDir).map(f => f.trim());
  } catch (e) {
    files = [];
  }
  const foundZip = files.find(f => f.toLowerCase() === (folder.toLowerCase() + ".zip"));
  let detailHtml = `
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${mod.name}</title>
${baseCSS}
</head>
<body>
<div class="top-bar">
<a href="index.html">Home</a>
</div>
<div class="teal-bar">Lilia Module Center</div>
<div class="detail-container">
<div class="left-column">
<div class="detail-header">
<h1>${mod.name}</h1>
<div class="author">by ${mod.author}</div>
</div>
<ul class="tabs">
<li class="active" data-tab="desc-tab" onclick="switchTab('desc-tab')">Description</li>
<li data-tab="lic-tab" onclick="switchTab('lic-tab')">License</li>
</ul>
<div class="tab-content">
<div id="desc-tab" class="tab-section">
${mod.desc}
</div>
<div id="lic-tab" class="tab-section" style="display:none">
${mod.license}
</div>
</div>
</div>
<div class="right-column">
<div class="download-box">
`;
  if (foundZip) {
    detailHtml += `
<a class="download-btn" href="Downloads/${foundZip}" download>Download</a>
`;
  } else {
    detailHtml += `<p>No download found.</p>`;
  }
  detailHtml += `
</div>
</div>
</div>
</body>
</html>
`;
  fs.writeFileSync(path.join(docsDir, detailFile), detailHtml);
});

fs.unlinkSync(modulesTxtPath);
