const fs = require("fs")
const path = require("path")
const jsonPath = path.join(__dirname, "modules.json")
if(!fs.existsSync(jsonPath)){process.exit(0)}
const rawData = fs.readFileSync(jsonPath,"utf8")
const modules = JSON.parse(rawData)
const docsDir = path.join(__dirname,"docs")
if(!fs.existsSync(docsDir)){fs.mkdirSync(docsDir)}
const indexHtml=`<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Plugin Modules</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:Arial,sans-serif;background-color:#fafafa}
.header{display:flex;align-items:center;background-color:#25746C;color:#fff;padding:10px 20px;justify-content:space-between}
.modules-link{color:#fff;text-decoration:none;font-weight:bold;margin-right:20px;font-size:1.1rem}
.modules-link:hover{text-decoration:underline}
.search-bar{position:relative}
.search-bar input{padding:6px 8px;border-radius:4px;border:none;outline:none}
main{max-width:1200px;margin:20px auto;padding:0 20px}
.plugin-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px}
@media(max-width:800px){.plugin-grid{grid-template-columns:1fr}}
.plugin-card{background-color:#fff;border-radius:4px;padding:15px;box-shadow:0 1px 3px rgba(0,0,0,0.1);display:flex;flex-direction:column;justify-content:center}
.plugin-card-header{margin-bottom:6px}
.plugin-card-title{font-size:1rem;font-weight:bold;color:#333}
.plugin-card-author{font-size:0.9rem;color:#555}
.plugin-card-version{font-size:0.9rem;color:#777}
.view-button{margin-top:10px;padding:6px 12px;background-color:#25746C;color:#fff;border:none;border-radius:4px;cursor:pointer;font-size:0.9rem}
.view-button:hover{background-color:#1d5f58}
.pagination{display:flex;justify-content:center;margin:20px 0;gap:5px}
.pagination button{background-color:#fff;border:1px solid #ccc;border-radius:4px;padding:6px 10px;cursor:pointer}
.pagination button.active{background-color:#25746C;color:#fff;border-color:#25746C}
.pagination button:hover{background-color:#eee}
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
const modules=${JSON.stringify(modules)}
const pageSize=8
let currentPage=1
let filteredModules=[...modules]
const pluginGrid=document.getElementById("pluginGrid")
const pagination=document.getElementById("pagination")
const searchInput=document.getElementById("search")
searchInput.addEventListener("input",()=>{
const q=searchInput.value.trim().toLowerCase()
filteredModules=modules.filter(m=>m.name.toLowerCase().includes(q))
currentPage=1
render()
})
function render(){renderGrid();renderPagination()}
function renderGrid(){
pluginGrid.innerHTML=""
const startIndex=(currentPage-1)*pageSize
const endIndex=startIndex+pageSize
const pageItems=filteredModules.slice(startIndex,endIndex)
pageItems.forEach(mod=>{
const card=document.createElement("div")
card.className="plugin-card"
card.innerHTML=`
<div class="plugin-card-header">
<div class="plugin-card-title">${mod.name}</div>
</div>
<div class="plugin-card-author">by ${mod.author||"Unknown"}</div>
<div class="plugin-card-version">Version: ${mod.version||"N/A"}</div>
<button class="view-button">View</button>
`
card.querySelector(".view-button").addEventListener("click",()=>{
window.location.href=slugify(mod.name)+".html"
})
pluginGrid.appendChild(card)
})
}
function renderPagination(){
pagination.innerHTML=""
const totalItems=filteredModules.length
const totalPages=Math.ceil(totalItems/pageSize)
if(totalPages<=1)return
for(let p=1;p<=totalPages;p++){
const btn=document.createElement("button")
btn.textContent=p
if(p===currentPage)btn.classList.add("active")
btn.addEventListener("click",()=>{currentPage=p;render()})
pagination.appendChild(btn)
}
}
function slugify(str){return str.toLowerCase().replace(/\\s+/g,"-").replace(/[^a-z0-9-]/g,"")}
render()
</script>
</body>
</html>`
fs.writeFileSync(path.join(docsDir,"index.html"),indexHtml,"utf8")
modules.forEach(mod=>{
const slug=slugify(mod.name)
const detailHtml=`<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>${mod.name||"Module Detail"}</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:Arial,sans-serif;background-color:#fafafa}
.header{display:flex;align-items:center;background-color:#25746C;color:#fff;padding:10px 20px;justify-content:space-between}
.modules-link{color:#fff;text-decoration:none;font-weight:bold;font-size:1.1rem}
.modules-link:hover{text-decoration:underline}
.main-content{max-width:1200px;margin:20px auto;padding:20px;display:flex;justify-content:space-between;align-items:flex-start}
.left-section{max-width:60%}
.module-title{font-size:1.6rem;margin-bottom:5px;color:#333}
.module-author{color:#555;margin-bottom:20px}
.tab-bar{display:flex;gap:15px;margin-bottom:20px}
.tab{border:none;background:none;cursor:pointer;font-size:1rem;color:#666;padding-bottom:4px}
.tab.active{border-bottom:2px solid #25746C;color:#25746C}
.tab-content{margin-bottom:20px}
.right-section{max-width:30%;background-color:#6B3D8F;color:#fff;border-radius:4px;padding:15px;text-align:center}
.download-title{font-size:1.1rem;margin-bottom:10px}
.download-link{text-decoration:none;color:#fff;display:block;margin-bottom:10px}
.download-link:hover{text-decoration:underline}
.view-source{text-decoration:none;color:#fff;font-size:0.9rem}
.view-source:hover{text-decoration:underline}
</style>
</head>
<body>
<header class="header">
<a href="index.html" class="modules-link">Modules</a>
</header>
<div class="main-content">
<div class="left-section">
<div class="module-title">${mod.name||"Untitled Module"}</div>
<div class="module-author">by ${mod.author||"Unknown"}</div>
<div class="tab-bar">
<button id="descTab" class="tab active">Description</button>
<button id="verTab" class="tab">Version</button>
</div>
<div id="descContent" class="tab-content">${mod.description||"No description provided."}</div>
<div id="verContent" class="tab-content" style="display:none">${mod.version||"N/A"}</div>
</div>
<div class="right-section">
<div class="download-title">Download</div>
<a href="${mod.downloadUrl||"#"}" class="download-link">via GitHub</a>
<a href="${mod.sourceUrl||"#"}" class="view-source">View source &raquo;</a>
</div>
</div>
<script>
const descTab=document.getElementById("descTab")
const verTab=document.getElementById("verTab")
const descContent=document.getElementById("descContent")
const verContent=document.getElementById("verContent")
descTab.addEventListener("click",()=>{
descTab.classList.add("active")
verTab.classList.remove("active")
descContent.style.display="block"
verContent.style.display="none"
})
verTab.addEventListener("click",()=>{
verTab.classList.add("active")
descTab.classList.remove("active")
verContent.style.display="block"
descContent.style.display="none"
})
</script>
</body>
</html>`
fs.writeFileSync(path.join(docsDir,slug+".html"),detailHtml,"utf8")
})
function slugify(str){return str.toLowerCase().replace(/\\s+/g,"-").replace(/[^a-z0-9-]/g,"")}
console.log("Done.")
