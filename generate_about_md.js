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

  const outputDir = path.join(__dirname, 'documentation', 'docs', 'modules', folder)
  fs.mkdirSync(outputDir, { recursive: true })

  const lines = []

  lines.push('<h1 style="text-align:center; font-size:2rem; font-weight:bold;">About</h1>')
  lines.push('')
  lines.push('**Name:**')
  lines.push(mod.name || '')
  lines.push('')
  lines.push('**Version:**')
  lines.push(mod.version || '')
  lines.push('')
  lines.push('**Description:**')
  lines.push('')
  lines.push(mod.description || '')
  lines.push('')

  if (Array.isArray(mod.features) && mod.features.length) {
    lines.push('<h2 style="text-align:center; font-size:1.5rem; font-weight:bold;">Features</h2>')
    lines.push('')
    for (const feature of mod.features) {
      lines.push(`- ${feature}`)
    }
    lines.push('')
    lines.push('')
  }

  if (Array.isArray(mod.workshop) && mod.workshop.length) {
    lines.push('<h2 style="text-align:center; font-size:1.5rem; font-weight:bold;">Workshop Content</h2>')
    lines.push('')
    for (const item of mod.workshop) {
      lines.push(`- ${item}`)
    }
    lines.push('')
    lines.push('')
  }

  if (mod.download) {
    lines.push('')
    lines.push('')
    lines.push('')
    lines.push(`<p align="center"><a href="${mod.download}" style="display:inline-block;padding:12px 24px;font-size:1.5rem;font-weight:bold;text-decoration:none;color:#fff;background-color:var(--md-primary-fg-color,#007acc);border-radius:4px;">DOWNLOAD HERE</a></p>`)
  }

  fs.writeFileSync(path.join(outputDir, 'about.md'), lines.join('\n'), 'utf8')
}

console.log('about.md files generated.')
