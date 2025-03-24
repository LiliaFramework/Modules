const fs = require("fs");
const path = require("path");

// 1. Read modules.json
const jsonPath = path.join(__dirname, "modules.json");
if (!fs.existsSync(jsonPath)) {
  console.log("modules.json not found, skipping site generation.");
  process.exit(0);
}

const rawData = fs.readFileSync(jsonPath, "utf8");
const modules = JSON.parse(rawData);

// 2. Ensure a docs folder exists
const docsDir = path.join(__dirname, "docs");
if (!fs.existsSync(docsDir)) {
  fs.mkdirSync(docsDir);
}

// 3. Build index.html
//    - Teal header bar (#25746C)
//    - "Modules" link (returns home) next to search
//    - Search only by module name
//    - Grid layout & pagination
//    - Clicking the entire card opens that module’s detail page
const indexHtml = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Plugin Modules</title>
  <style>
    /* --- Basic Reset & Body --- */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: Arial, sans-serif;
      background-color: #fafafa;
    }

    /* --- Header / Nav Bar --- */
    .header {
      display: flex;
      align-items: center;
      background-color: #25746C; /* teal */
      color: #fff;
      padding: 10px 20px;
      justify-content: space-between;
    }
    .modules-link {
      color: #fff;
      text-decoration: none;
      font-weight: bold;
      margin-right: 20px;
      font-size: 1.1rem;
    }
    .modules-link:hover {
      text-decoration: underline;
    }
    .search-bar {
      position: relative;
    }
    .search-bar input {
      padding: 6px 8px;
      border-radius: 4px;
      border: none;
      outline: none;
    }

    /* --- Main Layout --- */
    main {
      max-width: 1200px;
      margin: 20px auto;
      padding: 0 20px;
    }

    /* --- Plugin Grid --- */
    .plugin-grid {
      display: grid;
      grid-template-columns: 1fr 1fr; /* 2 columns */
      gap: 10px;
    }
    @media(max-width: 800px) {
      .plugin-grid {
        grid-template-columns: 1fr; /* 1 column on smaller screens */
      }
    }
    .plugin-card {
      background-color: #fff;
      border-radius: 4px;
      padding: 15px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: column;
      justify-content: center;
      cursor: pointer; /* indicates it's clickable */
    }
    .plugin-card-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 6px;
    }
    .plugin-card-title {
      font-size: 1rem;
      font-weight: bold;
      color: #333;
    }
    .plugin-card-date {
      font-size: 0.85rem;
      color: #999;
    }
    .plugin-card-author {
      font-size: 0.9rem;
      color: #555;
    }

    /* --- Pagination --- */
    .pagination {
      display: flex;
      justify-content: center;
      margin: 20px 0;
      gap: 5px;
    }
    .pagination button {
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 4px;
      padding: 6px 10px;
      cursor: pointer;
    }
    .pagination button.active {
      background-color: #25746C;
      color: #fff;
      border-color: #25746C;
    }
    .pagination button:hover {
      background-color: #eee;
    }
  </style>
</head>
<body>

  <!-- Top Bar / Header -->
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

    // DOM elements
    const pluginGrid = document.getElementById("pluginGrid");
    const pagination = document.getElementById("pagination");
    const searchInput = document.getElementById("search");

    // Search only by module name
    searchInput.addEventListener("input", () => {
      const query = searchInput.value.trim().toLowerCase();
      filteredModules = modules.filter(m => {
        return m.name.toLowerCase().includes(query);
      });
      currentPage = 1;
      render();
    });

    // Render function
    function render() {
      renderGrid();
      renderPagination();
    }

    function renderGrid() {
      pluginGrid.innerHTML = "";
      const startIndex = (currentPage - 1) * pageSize;
      const endIndex = startIndex + pageSize;
      const pageItems = filteredModules.slice(startIndex, endIndex);

      pageItems.forEach((mod, idx) => {
        const dateStr = mod.published || "No date";
        const card = document.createElement("div");
        card.className = "plugin-card";

        card.innerHTML = \`
          <div class="plugin-card-header">
            <div class="plugin-card-title">\${mod.name}</div>
            <div class="plugin-card-date">\${dateStr}</div>
          </div>
          <div class="plugin-card-author">
            by \${mod.author || "Unknown"}
          </div>
        \`;

        // Make the entire card clickable -> open detail page
        card.addEventListener("click", () => {
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

    // Create a slug from the module name
    function slugify(str) {
      return str.toLowerCase().replace(/\\s+/g, '-').replace(/[^a-z0-9-]/g, '');
    }

    // Initial render
    render();
  </script>
</body>
</html>
`;

// Write index.html
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml, "utf8");

// 4. Generate a detail page for each module
modules.forEach(mod => {
  const slug = slugify(mod.name);

  const detailHtml = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>${mod.name || "Module Detail"}</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #fafafa;
      margin: 0; 
      padding: 0;
    }
    .header {
      display: flex;
      align-items: center;
      background-color: #25746C;
      color: #fff;
      padding: 10px 20px;
      justify-content: space-between;
    }
    .modules-link {
      color: #fff;
      text-decoration: none;
      font-weight: bold;
      font-size: 1.1rem;
    }
    .modules-link:hover {
      text-decoration: underline;
    }
    main {
      max-width: 800px;
      margin: 20px auto;
      padding: 0 20px;
    }
    h1 {
      margin-bottom: 10px;
      color: #333;
    }
    .meta {
      margin-bottom: 20px;
      color: #555;
    }
    .description {
      line-height: 1.4;
      color: #333;
    }
  </style>
</head>
<body>
  <header class="header">
    <a href="index.html" class="modules-link">Modules</a>
  </header>
  <main>
    <h1>${mod.name || "Untitled Module"}</h1>
    <div class="meta">
      <p><strong>Author:</strong> ${mod.author || "Unknown"}</p>
      <p><strong>Published:</strong> ${mod.published || "N/A"}</p>
    </div>
    <div class="description">
      ${mod.description || "No description provided."}
    </div>
  </main>
</body>
</html>
`;

  fs.writeFileSync(path.join(docsDir, `${slug}.html`), detailHtml, "utf8");
});

// Helper function for slug
function slugify(str) {
  return str
    .toLowerCase()
    .replace(/\s+/g, '-')
    .replace(/[^a-z0-9-]/g, '');
}

console.log("Generated docs with index.html and individual module pages!");


/* 
  EXPLANATION OF CHANGES:

  1) Removed the original “Helix Plugin Center” text. 
  2) Added a “Modules” link in the header that always returns to index.html.
  3) Removed the modal logic entirely. 
     Instead, each plugin card has a click listener that navigates to a detail page (slug-based filename).
  4) Search is now only by module title (m.name).
  5) For each module, we generate a separate <slug>.html file that shows its details.
  6) The user can return from any detail page by clicking “Modules” in the header.
*/
