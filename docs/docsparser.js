const fs = require("fs");
const path = require("path");

// Utility to prevent HTML injection issues
function escapeHTML(str) {
  return str.replace(/[&<>"']/g, tag => {
    const chars = { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" };
    return chars[tag] || tag;
  });
}

// Path to your parsed modules file
const modulesTxtPath = path.join(__dirname, "..", "modules.txt");
if (!fs.existsSync(modulesTxtPath)) {
  console.log("No modules.txt found, exiting docs build.");
  process.exit(0);
}

const raw = fs.readFileSync(modulesTxtPath, "utf8");
// We assume 6 lines per module: Name, Author, Description, License, Schema, Published
const lines = raw.split("\n").map(l => l.trim()).filter(Boolean);

const data = [];
for (let i = 0; i < lines.length; i += 6) {
  // Using regex to capture the text inside "..."
  const name = lines[i]?.match(/^Name\s*=\s*"(.*)"$/)?.[1] || "Untitled";
  const author = lines[i + 1]?.match(/^Author\s*=\s*"(.*)"$/)?.[1] || "Unknown";
  const desc = lines[i + 2]?.match(/^Description\s*=\s*"(.*)"$/)?.[1] || "None";
  const license = lines[i + 3]?.match(/^License\s*=\s*"(.*)"$/)?.[1] || "None";
  const schema = lines[i + 4]?.match(/^Schema\s*=\s*"(.*)"$/)?.[1] || "Unknown";
  const published = lines[i + 5]?.match(/^Published\s*=\s*"(.*)"$/)?.[1] || "Unknown";

  data.push({
    name: escapeHTML(name),
    author: escapeHTML(author),
    desc: escapeHTML(desc),
    license: escapeHTML(license),
    schema: escapeHTML(schema),
    published: escapeHTML(published)
  });
}

// Create docs dir if needed
const docsDir = __dirname;
if (!fs.existsSync(docsDir)) fs.mkdirSync(docsDir);

// Downloads folder
const downloadsDir = path.join(docsDir, "Downloads");
if (!fs.existsSync(downloadsDir)) fs.mkdirSync(downloadsDir);

// We'll define some shared CSS for both index & detail pages.
// You can expand or tweak any of these to suit your design:
const baseCSS = `
<style>
  * { box-sizing: border-box; }
  body {
    margin: 0;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f6f6f6;
    color: #333;
  }
  /* Purple top bar (header) */
  header.navbar {
    background-color: #6a2f82;
    color: #fff;
    padding: 16px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  header.navbar .brand {
    font-size: 1.3rem;
    font-weight: bold;
  }
  header.navbar .navlinks a {
    color: #fff;
    text-decoration: none;
    margin-left: 16px;
    font-weight: normal;
  }
  header.navbar .navlinks a:hover {
    text-decoration: underline;
  }
  
  /* Index page container (grid of cards) */
  .module-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 16px;
    max-width: 1200px;
    margin: 20px auto 0 auto;
    padding: 0 20px 20px;
  }
  .module-card {
    background-color: #fff;
    border-radius: 4px;
    padding: 16px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
  }
  .module-card .module-title {
    font-weight: bold;
    font-size: 1.1rem;
    margin-bottom: 8px;
    color: #444;
  }
  .module-card .module-author {
    font-style: italic;
    margin-bottom: 8px;
    color: #666;
  }
  .module-card a {
    color: #6a2f82;
    text-decoration: none;
    font-weight: bold;
  }
  .module-card a:hover {
    text-decoration: underline;
  }

  /* Detail page layout */
  .detail-container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 0 20px 40px;
  }
  .detail-header {
    margin-bottom: 20px;
  }
  .detail-header h1 {
    margin: 0;
    font-weight: normal;
    font-size: 1.8rem;
    color: #444;
  }
  .detail-header .author {
    margin: 4px 0 0 0;
    font-size: 1rem;
    color: #666;
  }
  .detail-main {
    display: flex;
    gap: 20px;
  }
  /* Left column: tabs + content */
  .detail-left {
    flex: 2;
    background-color: #fff;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
  }
  .tabs {
    display: flex;
    list-style: none;
    margin: 0;
    padding: 8px 16px 0 16px;
    border-bottom: 1px solid #ddd;
  }
  .tabs li {
    margin-right: 20px;
    padding-bottom: 8px;
    cursor: pointer;
    color: #6a2f82;
  }
  .tabs li.active {
    font-weight: bold;
    border-bottom: 2px solid #6a2f82;
  }
  .tab-content {
    padding: 16px;
  }
  /* Right column: big purple box + info boxes */
  .detail-right {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
  .download-box {
    background-color: #6a2f82;
    color: #fff;
    padding: 16px;
    text-align: center;
    border-radius: 4px;
  }
  .download-box h2 {
    margin-top: 0;
  }
  .download-box a {
    display: block;
    color: #fff;
    text-decoration: underline;
    margin-top: 8px;
  }
  .download-box a:hover {
    opacity: 0.9;
  }
  .schema-box, .published-box {
    background-color: #fff;
    border-radius: 4px;
    padding: 16px;
    text-align: center;
    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
  }
  .schema-box .label, .published-box .label {
    font-weight: bold;
    color: #666;
    margin-bottom: 6px;
  }
  .report-link {
    text-align: center;
    margin-top: auto;
  }
  .report-link a {
    color: #6a2f82;
    font-weight: bold;
  }
  .report-link a:hover {
    text-decoration: underline;
  }

  /* Misc text / link styling within the content area */
  .tab-content a {
    color: #6a2f82;
  }
  .tab-content a:hover {
    text-decoration: underline;
  }
</style>
<script>
  // Very simple tab switching logic
  function switchTab(tabName) {
    var tabs = document.querySelectorAll('.tab-content > div');
    var tabButtons = document.querySelectorAll('.tabs li');
    tabs.forEach(function(t) {
      t.style.display = (t.id === tabName) ? 'block' : 'none';
    });
    tabButtons.forEach(function(btn) {
      if (btn.getAttribute('data-tab') === tabName) {
        btn.classList.add('active');
      } else {
        btn.classList.remove('active');
      }
    });
  }
</script>
`;

// =============== Generate index.html ===============
let indexHtml = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Helix Plugin Center</title>
  ${baseCSS}
</head>
<body>
<header class="navbar">
  <div class="brand">Helix Plugin Center</div>
  <div class="navlinks">
    <a href="#">Home</a>
    <a href="#">Plugins</a>
    <a href="#">Submit</a>
  </div>
</header>

<div class="module-container">
`;

// Render a “card” for each module
data.forEach(mod => {
  const folder = mod.name.replace(/\s+/g, "");
  indexHtml += `
  <div class="module-card">
    <div class="module-title">${mod.name}</div>
    <div class="module-author">by ${mod.author}</div>
    <div class="module-desc">${mod.desc}</div>
    <a href="module-${folder}.html">View Details</a>
  </div>
  `;
});

indexHtml += `</div></body></html>`;
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml);

// =============== Generate each detail page ===============
data.forEach(mod => {
  const folder = mod.name.replace(/\s+/g, "");
  const detailFile = `module-${folder}.html`;

  // See if there's a matching zip
  let files = [];
  try {
    files = fs.readdirSync(downloadsDir).map(f => f.trim());
  } catch (e) {
    files = [];
  }
  const foundZip = files.find(file => file.toLowerCase() === (folder.toLowerCase() + ".zip"));

  // Build the detail page
  let detailHtml = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${mod.name}</title>
  ${baseCSS}
</head>
<body>
<header class="navbar">
  <div class="brand">Helix Plugin Center</div>
  <div class="navlinks">
    <a href="index.html">Home</a>
    <a href="index.html">Plugins</a>
    <a href="#">Submit</a>
  </div>
</header>

<div class="detail-container">
  <div class="detail-header">
    <h1>${mod.name}</h1>
    <div class="author">by ${mod.author}</div>
  </div>

  <div class="detail-main">
    <!-- Left: Description/License tabs -->
    <div class="detail-left">
      <ul class="tabs">
        <li class="active" data-tab="description-tab" onclick="switchTab('description-tab')">Description</li>
        <li data-tab="license-tab" onclick="switchTab('license-tab')">License</li>
      </ul>
      <div class="tab-content">
        <div id="description-tab">
          <p>${mod.desc}</p>
        </div>
        <div id="license-tab" style="display:none;">
          <p>${mod.license}</p>
        </div>
      </div>
    </div>

    <!-- Right: Download box, schema, published, etc. -->
    <div class="detail-right">
      <div class="download-box">
        <h2>Download</h2>
  `;

  if (foundZip) {
    detailHtml += `
        <a href="Downloads/${foundZip}" download>via GitHub</a>
        <a href="https://github.com/YourOrg/YourRepo">View source &raquo;</a>
    `;
  } else {
    detailHtml += `<p>No download found.</p>`;
  }

  detailHtml += `
      </div>
      <div class="schema-box">
        <div class="label">Schema</div>
        <div>${mod.schema}</div>
      </div>
      <div class="published-box">
        <div class="label">Published</div>
        <div>${mod.published}</div>
      </div>
      <div class="report-link">
        <a href="#">Report plugin</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
`;

  fs.writeFileSync(path.join(docsDir, detailFile), detailHtml);
});

// Optionally remove modules.txt
fs.unlinkSync(modulesTxtPath);
