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

for (const mod of modules) {
  const id = mod.uniqueID || ''
  if (!id) continue

  const folder = toFolderName(mod.name || id)

  const readmePath = path.join(__dirname, folder, 'README.md')
  if (!fs.existsSync(readmePath)) continue

  const outputDir = path.join(__dirname, 'documentation', 'docs', 'modules', folder)
  fs.mkdirSync(outputDir, { recursive: true })

  fs.copyFileSync(readmePath, path.join(outputDir, 'about.md'))
}

console.log('README.md files copied as about.md.')
