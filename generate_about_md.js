const fs = require('fs')
const path = require('path')

let modulesPath = path.join(__dirname, 'modules.json')
if (!fs.existsSync(modulesPath)) {
  const altPath = path.join(__dirname, 'documentation', 'modules.json')
  if (fs.existsSync(altPath)) {
    modulesPath = altPath
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

for (const mod of modules) {
  const id = mod.public_uniqueID || ''
  if (!id) continue
  const dest = path.join(__dirname, 'documentation', 'docs', 'modules', id)
  fs.mkdirSync(dest, { recursive: true })

  const lines = []
  lines.push('# About')
  lines.push('')
  lines.push(`# ${mod.name || ''}${mod.version ? ` (${mod.version})` : ''}`)
  lines.push('')
  lines.push(`Description:`)
  lines.push('')
  lines.push(mod.description || '')
  lines.push('')

  if (Array.isArray(mod.features) && mod.features.length) {
    lines.push(`Features:`)
    lines.push('')
    for (const feat of mod.features) {
      lines.push(feat)
      lines.push('')
    }
  }

  if (Array.isArray(mod.workshop) && mod.workshop.length) {
    lines.push(`Workshop Content`)
    lines.push('')
    for (const item of mod.workshop) {
      lines.push(item)
      lines.push('')
    }
  }

  if (mod.download) {
    lines.push(
      `<p align="center"><a href="${mod.download}" ` +
      `style="display:inline-block;padding:12px 24px;` +
      `font-size:1.5rem;font-weight:bold;text-decoration:none;` +
      `color:#fff;background-color:#007acc;border-radius:4px;">` +
      `DOWNLOAD HERE</a></p>`
    )
  }

  fs.writeFileSync(path.join(dest, 'about.md'), lines.join('\n'))
}

console.log('about.md files generated.')