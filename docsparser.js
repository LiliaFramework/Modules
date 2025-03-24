const fs = require("fs");
const path = require("path");

// 1. Read modules.json
//    Make sure modules.json is in the same folder as docsparser.js
const jsonPath = path.join(__dirname, "modules.json");
if (!fs.existsSync(jsonPath)) {
  console.log("modules.json not found, skipping site generation.");
  process.exit(0);
}

const rawData = fs.readFileSync(jsonPath, "utf8");
const modules = JSON.parse(rawData);

// 2. Ensure a docs folder exists (GitHub Pages will publish from here)
const docsDir = path.join(__dirname, "docs");
if (!fs.existsSync(docsDir)) {
  fs.mkdirSync(docsDir);
}

// 3. Build index.html with a grid layout and pagination
//    We'll inject the modules data into a <script> tag and then
//    do client-side rendering of the grid + pagination.

const indexHtml = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Helix Plugin Center</title>
  <style>
    /* --- Basic Reset & Body --- */
    * {
      margin: 0; padding: 0; box-sizing: border-box;
    }
    body {
      font-family: Arial, sans-serif;
      background-color: #fafafa;
    }

    /* --- Header / Nav Bar --- */
    .header {
      display: flex;
      align-items: center;
      background-color: #6a1b9a; /* purple bar */
      color: #fff;
      padding: 10px 20px;
    }
    .header .title {
      font-size: 1.4rem;
      font-weight: bold;
    }
    .nav-links {
      margin-left: auto;
      display: flex;
      gap: 20px;
    }
    .nav-links a {
      color: #fff;
      text-decoration: none;
      font-weight: 500;
    }
    .search-bar {
      margin-left: 20px;
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
      background-color: #6a1b9a;
      color: #fff;
      border-color: #6a1b9a;
    }
    .pagination button:hover {
      background-color: #eee;
    }
  </style>
</head>
<body>

  <!-- Top Bar / Header -->
  <header class="header">
    <div class="title">Helix Plugin Center</div>
    <nav class="nav-links">
      <a href="#">Home</a>
      <a href="#">Plugins</a>
      <a href="#">Submit</a>
    </nav>
    <div class="search-bar">
      <input type="text" id="search" placeholder="Search...">
    </div>
  </header>

  <main>
    <!-- The grid and pagination will be rendered via JS below -->
    <div class="plugin-grid" id="pluginGrid"></div>
    <div class="pagination" id="pagination"></div>
  </main>

  <script>
    // We'll load module data into a global array in JS.
    // In a real environment, you'd do server-side rendering or fetch JSON.
    const modules = ${JSON.stringify(modules, null, 2)};

    // Pagination settings
    const pageSize = 8; // 8 cards per page
    let currentPage = 1;
    let filteredModules = [...modules]; // By default, show all

    // --- Query DOM elements ---
    const pluginGrid = document.getElementById("pluginGrid");
    const pagination = document.getElementById("pagination");
    const searchInput = document.getElementById("search");

    // --- Listen for search changes ---
    searchInput.addEventListener("input", () => {
      const query = searchInput.value.trim().toLowerCase();
      filteredModules = modules.filter(m => {
        return (
          m.name.toLowerCase().includes(query) ||
          m.author.toLowerCase().includes(query) ||
          m.description.toLowerCase().includes(query)
        );
      });
      currentPage = 1;
      render();
    });

    // --- Render function (grid + pagination) ---
    function render() {
      renderGrid();
      renderPagination();
    }

    // --- Render the plugin grid for the current page ---
    function renderGrid() {
      pluginGrid.innerHTML = "";
      const startIndex = (currentPage - 1) * pageSize;
      const endIndex = startIndex + pageSize;
      const pageItems = filteredModules.slice(startIndex, endIndex);

      pageItems.forEach(mod => {
        // Use published date or fallback
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
        pluginGrid.appendChild(card);
      });
    }

    // --- Render pagination buttons ---
    function renderPagination() {
      pagination.innerHTML = "";
      const totalItems = filteredModules.length;
      const totalPages = Math.ceil(totalItems / pageSize);

      // If only 1 page, no need for pagination
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

// 4. Write the new index.html to the docs folder
fs.writeFileSync(path.join(docsDir, "index.html"), indexHtml, "utf8");

console.log("Generated docs/index.html with a Helix-style plugin grid!");
