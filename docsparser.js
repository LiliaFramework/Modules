const fs = require("fs");
const path = require("path");

const jsonPath = path.join(__dirname, "modules.json");
if (!fs.existsSync(jsonPath)) {
  console.log("modules.json not found, skipping site generation.");
  process.exit(0);
}

function slugify(str) {
  return str
    .toLowerCase()
    .replace(/\s+/g, '-')
    .replace(/[^a-z0-9-]/g, '');
}

const rawData = fs.readFileSync(jsonPath, "utf8");
const modules = JSON.parse(rawData);

const docsDir = path.join(__dirname, "docs");
if (!fs.existsSync(docsDir)) {
  fs.mkdirSync(docsDir);
}

const primaryColor = "rgb(37, 116, 108)";
const hoverColor = "rgb(29, 95, 88)";
const buttonColor = "rgb(37, 116, 108)";
const buttonHoverColor = "rgb(29, 95, 88)";
const darkBackgroundColor = "#1f1f1f"; // Dark background for the website
const darkTextColor = "#e0e0e0"; // Light text for readability

const indexHtml = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Plugin Modules</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: Arial, sans-serif; background-color: ${darkBackgroundColor}; color: ${darkTextColor}; }
    .header { display: flex; align-items: center; background-color: ${primaryColor}; color: #fff; padding: 10px 20px; justify-content: space-between; }
    .modules-link { color: #fff; text-decoration: none; font-weight: bold; margin-right: 20px; font-size: 1.1rem; }
    .modules-link:hover { text-decoration: underline; }
    .search-bar { position: relative; }
    .search-bar input { padding: 6px 8px; border-radius: 4px; border: none; outline: none; background-color: #333; color: #fff; }
    main { max-width: 1200px; margin: 20px auto; padding: 0 20px; }
    .plugin-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
    @media(max-width: 800px) { .plugin-grid { grid-template-columns: 1fr; } }
    .plugin-card { background-color: #2e2e2e; border-radius: 4px; padding: 15px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); display: flex; flex-direction: column; justify-content: center; }
    .plugin-card-header { margin-bottom: 6px; }
    .plugin-card-title { font-size: 1rem; font-weight: bold; color: ${darkTextColor}; }
    .plugin-card-author { font-size: 0.9rem; color: #bbb; }
    .plugin-card-version { font-size: 0.9rem; color: #777; }
    .view-button { margin-top: 10px; padding: 12px 24px; background-color: ${buttonColor}; color: #fff; border: none; border-radius: 6px; cursor: pointer; font-size: 1.2rem; }
    .view-button:hover { background-color: ${buttonHoverColor}; }
    .pagination { display: flex; justify-content: center; margin: 20px 0; gap: 5px; }
    .pagination button { background-color: #2e2e2e; border: 1px solid #555; border-radius: 4px; padding: 10px 20px; cursor: pointer; color: ${darkTextColor}; }
    .pagination button.active { background-color: ${primaryColor}; color: #fff; border-color: ${primaryColor}; }
    .pagination button:hover { background-color: #444; }
  </style>
</head>
<body>
  <header class="header">
    <a href="index.html" class="modules-link">Modules</a>
    <div class="search-bar">
      <input type="text" id="search" placeholder="Search by Title...">
    </div>
  </header>
  <main>
    <div class="plugin-grid" id="pluginGrid"></div>
    <div class="pagination" id="pagination"></div>
  </main>
  <script>
    const modules = ${JSON.stringify(modules, null, 2)};
    const pageSize = 8;
    let currentPage = 1;
    let filteredModules = [...modules];

    const pluginGrid = document.getElementById("pluginGrid");
    const pagination = document.getElementById("pagination");
    const searchInput = document.getElementById("search");

    searchInput.addEventListener("input", () => {
      const query = searchInput.value.trim().toLowerCase();
      filteredModules = modules.filter(m => m.name.toLowerCase().includes(query));
      currentPage = 1;
      render();
    });

    function render() {
      renderGrid();
      renderPagination();
    }

    function renderGrid() {
      pluginGrid.innerHTML = "";
      const startIndex = (currentPage - 1) * pageSize;
      const endIndex = startIndex + pageSize;
      const pageItems = filteredModules.slice(startIndex, endIndex);

      pageItems.forEach((mod) => {
        const card = document.createElement("div");
        card.className = "plugin-card";

        card.innerHTML = \`
          <div class="plugin-card-header">
            <div class="plugin-card-title">\${mod.name}</div>
          </div>
          <div class="plugin-card-author">
            by \${mod.author || "Unknown"}
          </div>
          <div class="plugin-card-version">
            Version: \${mod.version || "N/A"}
          </div>
          <button class="view-button">View</button>
        \`;

        const viewBtn = card.querySelector(".view-button");
        viewBtn.addEventListener("click", () => {
          const slug = slugify(mod.name);
          window.location.href = slug + ".html";
        });

        pluginGrid.appendChild(card);
      });
    }

    function renderPagination() {
      pagination.innerHTML = "";
      const totalItems = filteredModules.length;
      const totalPages = Math.ceil(totalItems / pageSize);
      if (totalPages <= 1) return;

      for (let p = 1; p <= totalPages; p++) {
        const btn = document.createElement("button");
        btn.textContent = p;
        if (p === currentPage) {
          btn.classList.add("active");
        }
        btn.addEventListener("click", () => {
          currentPage = p;
          render();
        });
        pagination.appendChild(btn);
      }
    }

    function slugify(str) {
      return str
        .toLowerCase()
        .replace(/\\s+/g, '-')
        .replace(/[^a-z0-9-]/g, '');
    }

    render();
  </script>
</body>
</html>
`;

fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml, "utf8");

modules.forEach(mod => {
  const slug = slugify(mod.name);

  const detailHtml = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>${mod.name || "Module Detail"}</title>
  <style>
    body { font-family: Arial, sans-serif; background-color: ${darkBackgroundColor}; color: ${darkTextColor}; margin: 0; padding: 0; }
    .container { max-width: 900px; margin: 40px auto; background-color: #333; padding: 20px 30px; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
    .header { display: flex; justify-content: space-between; align-items: flex-start; }
    .header-left { max-width: 60%; }
    .header-left h1 { margin: 0 0 5px 0; font-size: 1.5rem; color: ${darkTextColor}; }
    .header-left .author { color: #bbb; margin-bottom: 10px; }
    .header-right { text-align: right; }
    .download-button { display: inline-block; background-color: ${buttonColor}; color: #fff; padding: 18px 36px; border-radius: 6px; text-decoration: none; font-weight: bold; font-size: 1.2rem; }
    .download-button:hover { background-color: ${buttonHoverColor}; }
    .view-source { display: block; margin-top: 8px; color: ${buttonColor}; text-decoration: none; font-weight: normal; }
    .view-source:hover { text-decoration: underline; }
    .description, .version { margin-top: 20px; color: ${darkTextColor}; line-height: 1.4; }
    .description strong, .version strong { display: inline-block; margin-bottom: 6px; }
    .back-link { display: inline-block; margin-bottom: 20px; color: ${primaryColor}; text-decoration: none; font-weight: bold; }
    .back-link:hover { text-decoration: underline; }
  </style>
</head>
<body>
  <div class="container">
    <a class="back-link" href="index.html">← Modules</a>
    <div class="header">
      <div class="header-left">
        <h1>${mod.name || "Untitled Module"}</h1>
        <div class="author">by ${mod.author || "Unknown"}</div>
      </div>
      <div class="header-right">
        <a class="download-button" href="${mod.source}">Download via GitHub</a>
        <a class="view-source" href="${mod.source}">View source »</a>
      </div>
    </div>
    <div class="description">
      <strong>Description</strong>
      <p>${mod.description || "No description provided."}</p>
    </div>
    <div class="version">
      <strong>Version</strong>
      <p>${mod.version || "N/A"}</p>
    </div>
  </div>
</body>
</html>
`;

  fs.writeFileSync(path.join(docsDir, `${slug}.html`), detailHtml, "utf8");
});

console.log("Generated docs with index.html and detailed pages with View Source links and RGB styling.");