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
//    - Single page with a top bar in #25746C
//    - Search bar (titles only)
//    - "Modules" link next to the search bar
//    - Grid layout
//    - Pagination
//    - A "View" button that opens a new page for that module
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
      background-color: rgb(37,116,108); /* #25746C */
      color: #fff;
      padding: 10px 20px;
      justify-content: space-between;
    }

    /* Remove the old .title usage; we won't display "Helix Plugin Center" anymore */
    .modules-bar {
      display: flex;
      align-items: center;
      gap: 20px;
    }
    .modules-link a {
      color: #fff;
      text-decoration: none;
      font-weight: bold;
    }
    .modules-link a:hover {
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
    .view-button {
      margin-top: 8px;
      align-self: flex-start;
      padding: 6px 12px;
      background-color: rgb(37,116,108);
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    .view-button:hover {
      background-color: #1d5f58; /* Darken on hover */
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
      background-color: rgb(37,116,108);
      color: #fff;
      border-color: rgb(37,116,108);
    }
    .pagination button:hover {
      background-color: #eee;
    }
  </style>
</head>
<body>

  <!-- Header with "Modules" link and search bar (titles only) -->
  <header class="header">
    <div class="modules-bar">
      <div class="modules-link">
        <a href="index.html">Modules</a>
      </div>
    </div>
    <div class="search-bar">
      <input type="text" id="search" placeholder="Search by title...">
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

    // We'll only search against 'mod.name'
    let filteredModules = [...modules];

    // DOM elements
    const pluginGrid = document.getElementById("pluginGrid");
    const pagination = document.getElementById("pagination");
    const searchInput = document.getElementById("search");

    // Search only by module name
    searchInput.addEventListener("input", () => {
      const query = searchInput.value.trim().toLowerCase();
      filteredModules = modules.filter(m =>
        m.name.toLowerCase().includes(query)
      );
      currentPage = 1;
      render();
    });

    // When user clicks "View," open a new page for that module
    function openModulePage(mod) {
      // For example, we can go to a page named after the module
      // You could also do window.open(...) if you want a new tab
      const moduleUrl = \`module-\${encodeURIComponent(mod.name)}.html\`;
      window.location.href = moduleUrl;
    }

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
          <button class="view-button">View</button>
        \`;

        // On click => go to the module's page
        card.querySelector(".view-button").addEventListener("click", () => {
          openModulePage(mod);
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

    // Initial render
    render();
  </script>
</body>
</html>
`;

// 4. Write index.html to docs
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml, "utf8");

console.log("Generated docs/index.html with the requested adjustments!"); 