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
//    - Search bar
//    - Grid layout
//    - Pagination
//    - “View” button -> opens a modal with module details
const indexHtml = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Helix Plugin Center</title>
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
    .header .title {
      font-size: 1.4rem;
      font-weight: bold;
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

    /* --- Modal Styles --- */
    .modal {
      display: none; /* hidden by default */
      position: fixed; 
      z-index: 999; 
      left: 0; 
      top: 0; 
      width: 100%; 
      height: 100%; 
      overflow: auto; 
      background-color: rgba(0,0,0,0.5);
    }
    .modal-content {
      background-color: #fff;
      margin: 100px auto;
      padding: 20px;
      border-radius: 4px;
      max-width: 600px;
      position: relative;
      box-shadow: 0 2px 6px rgba(0,0,0,0.2);
    }
    .close-btn {
      position: absolute;
      top: 10px;
      right: 15px;
      font-size: 1.2rem;
      cursor: pointer;
      color: #aaa;
    }
    .close-btn:hover {
      color: #000;
    }
    .modal-title {
      font-size: 1.2rem;
      margin-bottom: 8px;
    }
    .modal-author {
      font-size: 1rem;
      color: #555;
      margin-bottom: 8px;
    }
    .modal-description {
      font-size: 0.95rem;
      color: #333;
    }
  </style>
</head>
<body>

  <!-- Top Bar / Header (No extra links) -->
  <header class="header">
    <div class="title">Helix Plugin Center</div>
    <div class="search-bar">
      <input type="text" id="search" placeholder="Search...">
    </div>
  </header>

  <main>
    <div class="plugin-grid" id="pluginGrid"></div>
    <div class="pagination" id="pagination"></div>
  </main>

  <!-- Modal -->
  <div class="modal" id="modal">
    <div class="modal-content">
      <span class="close-btn" id="closeModal">&times;</span>
      <div class="modal-title" id="modalTitle"></div>
      <div class="modal-author" id="modalAuthor"></div>
      <div class="modal-description" id="modalDescription"></div>
    </div>
  </div>

  <script>
    const modules = ${JSON.stringify(modules, null, 2)};
    const pageSize = 8;
    let currentPage = 1;
    let filteredModules = [...modules];

    // DOM elements
    const pluginGrid = document.getElementById("pluginGrid");
    const pagination = document.getElementById("pagination");
    const searchInput = document.getElementById("search");
    const modal = document.getElementById("modal");
    const closeModalBtn = document.getElementById("closeModal");
    const modalTitle = document.getElementById("modalTitle");
    const modalAuthor = document.getElementById("modalAuthor");
    const modalDescription = document.getElementById("modalDescription");

    // Search
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

    // Modal
    function openModal(index) {
      const mod = filteredModules[index];
      modalTitle.textContent = mod.name || "Untitled";
      modalAuthor.textContent = "by " + (mod.author || "Unknown");
      modalDescription.textContent = mod.description || "No description.";
      modal.style.display = "block";
    }
    function closeModal() {
      modal.style.display = "none";
    }
    closeModalBtn.addEventListener("click", closeModal);
    window.addEventListener("click", (e) => {
      if (e.target === modal) {
        closeModal();
      }
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
          <button class="view-button">View</button>
        \`;

        // When user clicks "View," open the modal with this plugin's data
        const viewBtn = card.querySelector(".view-button");
        viewBtn.addEventListener("click", () => {
          // Because pageItems is a slice of filteredModules, 
          // we can figure out the actual index in filteredModules
          const actualIndex = startIndex + idx;
          openModal(actualIndex);
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

console.log("Generated docs/index.html with a Helix-style plugin grid, teal bar, search, and modal UI!");
