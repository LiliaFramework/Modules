const fs = require("fs");
const path = require("path");

// Simple function to escape HTML special characters:
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

// Read and parse modules.txt:
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

const downloadsDir = path.join(docsDir, "Downloads");
if (!fs.existsSync(downloadsDir)) fs.mkdirSync(downloadsDir);

// We'll define a single CSS string we can inject into all pages:
const baseCSS = `
<style>
body {
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: #f6f6f6;
  color: #333;
}
header {
  background-color: #6a2f82; /* Purple bar up top */
  color: white;
  padding: 20px;
  margin-bottom: 20px;
}
header h1 {
  margin: 0;
  font-size: 1.5rem;
}
/* The main container for the index page modules */
.module-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 16px;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px 20px;
}
/* Each card for an individual module on the index page */
.module-card {
  background-color: #fff;
  border-radius: 4px;
  padding: 16px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.2);
}
.module-title {
  font-weight: bold;
  font-size: 1.1rem;
  margin-bottom: 8px;
  color: #444;
}
.module-author {
  font-style: italic;
  margin-bottom: 8px;
  color: #666;
}
.module-desc {
  color: #555;
}
/* Detail page container */
.detail-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 0 20px 20px;
}
.back-link {
  display: inline-block;
  margin-bottom: 16px;
  color: #6a2f82;
  text-decoration: none;
  font-weight: bold;
}
.back-link:hover {
  text-decoration: underline;
}
.detail-card {
  background-color: #fff;
  border-radius: 4px;
  padding: 16px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.2);
}
.detail-title {
  font-weight: bold;
  font-size: 1.3rem;
  margin-bottom: 8px;
  color: #444;
}
.detail-author {
  font-style: italic;
  margin-bottom: 12px;
  color: #666;
}
.download-link {
  color: #007acc;
  text-decoration: none;
  font-weight: bold;
}
.download-link:hover {
  text-decoration: underline;
}
</style>
`;

// Generate the index.html
let indexHtml = `<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modules</title>
${baseCSS}
</head>
<body>
<header>
  <h1>Modules</h1>
</header>
<div class="module-container">
`;

// For each module, create a “card” on the main index page
data.forEach(mod => {
    const folder = mod.name.replace(/\s+/g, "");
    // We'll link to the detail page, “module-<folder>.html”
    indexHtml += `
    <div class="module-card">
      <div class="module-title">${mod.name}</div>
      <div class="module-author">by ${mod.author}</div>
      <div class="module-desc">${mod.desc}</div>
      <a href="module-${folder}.html" class="download-link">More Info</a>
    </div>
    `;
});

indexHtml += `
</div>
</body>
</html>
`;

// Write the index.html
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml.trim());

// Generate detail pages for each module
data.forEach(mod => {
    const folder = mod.name.replace(/\s+/g, "");
    const detailFile = `module-${folder}.html`;

    // Attempt to see if a matching ZIP is in /Downloads
    let files = [];
    try {
        files = fs.readdirSync(downloadsDir).map(f => f.trim());
    } catch (e) {
        files = [];
    }
    let foundZip = files.find(file => file.toLowerCase() === (folder.toLowerCase() + ".zip"));

    // Build the detail page
    let detailHtml = `<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${mod.name}</title>
${baseCSS}
</head>
<body>
<header>
  <h1>Module Detail</h1>
</header>
<div class="detail-container">
  <a href="index.html" class="back-link">&laquo; Back to Index</a>
  <div class="detail-card">
    <div class="detail-title">${mod.name}</div>
    <div class="detail-author">by ${mod.author}</div>
    <p>${mod.desc}</p>
`;

    if (foundZip) {
        // Present a download link
        detailHtml += `
    <p><a href="Downloads/${foundZip}" class="download-link" download>Download Module ZIP</a></p>
`;
    } else {
        detailHtml += `    <p>No Module ZIP found.</p>\n`;
    }

    detailHtml += `
  </div> <!-- detail-card -->
</div> <!-- detail-container -->
</body>
</html>
`;

    fs.writeFileSync(path.join(docsDir, detailFile), detailHtml.trim());
});

// Finally, remove modules.txt so it doesn’t re-trigger:
fs.unlinkSync(modulesTxtPath);
