const fs = require('fs')
const path = require('path')

let modulesPath = path.join(__dirname, 'modules.json')
if (!fs.existsSync(modulesPath)) {
  const alternativePath = path.join(__dirname, 'documentation', 'modules.json')
  if (fs.existsSync(alternativePath)) {
    modulesPath = alternativePath
  } else {
    process.exit(1)
  }
}

let modules
try {
  modules = JSON.parse(fs.readFileSync(modulesPath, 'utf8'))
} catch {
  process.exit(1)
}
if (!Array.isArray(modules)) process.exit(1)

function toFolderName(name) {
  return String(name)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '_')
    .replace(/^_+|_+$/g, '')
}

function toSlug(name) {
  return String(name)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-$/g, '')
}

function parseREADME(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8')
    
    // Extract name
    const nameMatch = content.match(/\*\*Name:\*\*\s*(.+)/)
    const name = nameMatch ? nameMatch[1].trim() : ''
    
    // Extract description (everything between "Description:" and the next heading or end)
    const descMatch = content.match(/\*\*Description:\*\*\s*\n\n(.+?)(?:\n\n<h2|<h3|\n<p align|$)/s)
    const description = descMatch ? descMatch[1].trim() : ''
    
    return { name, description }
  } catch (error) {
    return { name: '', description: '' }
  }
}

// First, copy README.md files as about.md
for (const mod of modules) {
  const id = mod.versionID || ''
  if (!id) continue

  const folder = toFolderName(mod.name || id)

  const readmePath = path.join(__dirname, folder, 'README.md')
  if (!fs.existsSync(readmePath)) continue

  const outputDir = path.join(__dirname, 'documentation', 'docs', 'modules', folder)
  fs.mkdirSync(outputDir, { recursive: true })

  fs.copyFileSync(readmePath, path.join(outputDir, 'about.md'))
}

console.log('README.md files copied as about.md.')

// Generate modules.md
const outputPath = path.join(__dirname, 'documentation', 'modules.md')
const outputDir = path.dirname(outputPath)

// Ensure documentation directory exists
fs.mkdirSync(outputDir, { recursive: true })

let moduleList = []

// Get all directories in the current folder
const entries = fs.readdirSync(__dirname, { withFileTypes: true })

for (const entry of entries) {
  if (!entry.isDirectory()) continue
  if (entry.name === '.github' || entry.name === 'node_modules' || entry.name === 'documentation') continue
  
  const moduleDir = path.join(__dirname, entry.name)
  const readmePath = path.join(moduleDir, 'README.md')
  
  if (!fs.existsSync(readmePath)) continue
  
  const { name, description } = parseREADME(readmePath)
  if (!name) continue
  
  moduleList.push({ name, description, folder: entry.name })
}

// Sort modules alphabetically
moduleList.sort((a, b) => a.name.localeCompare(b.name))

// Generate markdown content
let markdown = '# List of Modules\n\n'

for (const module of moduleList) {
  const slug = toSlug(module.name)
  const url = `https://bleonheart.github.io/modules/${slug}/`
  
  markdown += `## [${module.name}](${url})\n`
  markdown += `${module.description}\n\n`
}

fs.writeFileSync(outputPath, markdown)

console.log(`Generated modules.md with ${moduleList.length} modules at ${outputPath}`)
