const fs = require('fs')
const path = require('path')

const documentationDir = path.join(__dirname, 'documentation')
const docsModulesDir = path.join(documentationDir, 'docs', 'modules')
const modulesMdPath = path.join(documentationDir, 'docs', 'modules.md')
const modulesIndexMdPath = path.join(docsModulesDir, 'index.md')

function toSlug(name) {
  return String(name)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-$/g, '')
}

function parseLuaTable(content) {
  if (!content) return []
  const items = []
  // Matches "string" entries in a list
  const regex = /"([^"]+)"/g
  let match
  while ((match = regex.exec(content)) !== null) {
    items.push(match[1].trim())
  }
  return items
}

function parseChangelog(content) {
  if (!content) return {}
  const changelog = {}

  // Match table format: ["version"] = { "entry1", "entry2" }
  const tableRegex = /\["([^"]+)"\]\s*=\s*\{([\s\S]*?)\}/g
  let match
  while ((match = tableRegex.exec(content)) !== null) {
    const version = match[1]
    const entries = parseLuaTable(match[2])
    changelog[version] = entries
  }

  // Match string format: ["version"] = "entry"
  const stringRegex = /\["([^"]+)"\]\s*=\s*"([^"]*)"/g
  while ((match = stringRegex.exec(content)) !== null) {
    const version = match[1]
    const entry = match[2]
    changelog[version] = [entry]
  }

  return changelog
}

function extractMetadata(filePath) {
  const content = fs.readFileSync(filePath, 'utf8')
  const metadata = {}

  metadata.name = (content.match(/MODULE\.name\s*=\s*"([^"]*)"/) || [])[1]
  metadata.versionID = (content.match(/MODULE\.versionID\s*=\s*"([^"]*)"/) || [])[1]
  metadata.author = (content.match(/MODULE\.author\s*=\s*"([^"]*)"/) || [])[1]
  metadata.discord = (content.match(/MODULE\.discord\s*=\s*"([^"]*)"/) || [])[1]
  metadata.version = (content.match(/MODULE\.version\s*=\s*([0-9.]+)/) || [])[1] || '0.0'
  metadata.description = (content.match(/MODULE\.desc\s*=\s*"([^"]*)"/) || [])[1]

  const changelogMatch = content.match(/MODULE\.Changelog\s*=\s*\{([\s\S]*?)\}/)
  metadata.changelogData = changelogMatch ? parseChangelog(changelogMatch[1]) : {}

  return metadata
}

function main() {
  const rootDir = __dirname
  const modules = []

  // Ensure directories exist
  if (!fs.existsSync(docsModulesDir)) {
    fs.mkdirSync(docsModulesDir, { recursive: true })
  }

  // Scan all directories for module.lua
  const items = fs.readdirSync(rootDir)
  for (const item of items) {
    const itemPath = path.join(rootDir, item)
    if (fs.statSync(itemPath).isDirectory()) {
      if (item === 'documentation' || item === '.github' || item === '.git' || item === 'node_modules') continue

      const moduleLuaPath = path.join(itemPath, 'module.lua')
      if (fs.existsSync(moduleLuaPath)) {
        const metadata = extractMetadata(moduleLuaPath)
        metadata.folder = item
        metadata.download = `https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/${item}.zip`
        modules.push(metadata)
      }
    }
  }

  // Sort modules alphabetically
  modules.sort((a, b) => (a.name || '').localeCompare(b.name || ''))

  const grouped = {
    'Modules': [],
    'Droppers': []
  }

  modules.forEach(mod => {
    const name = mod.name || 'Unknown'
    if (name.toLowerCase().includes('dropper')) {
      grouped['Droppers'].push(mod)
    } else {
      grouped['Modules'].push(mod)
    }
  })

  let markdown = '# Modules\n\n'

  const categories = ['Modules', 'Droppers']
  categories.forEach(category => {
    const mods = grouped[category]
    if (mods.length === 0 && category === 'Droppers') return

    if (category !== 'Modules') {
      markdown += `## ${category}\n\n`
    }

    if (mods.length === 0) {
      markdown += 'No modules found.\n\n'
      return
    }

    mods.forEach(mod => {
      const name = mod.name || 'Unknown'
      const description = mod.description || 'No description available.'
      const download = mod.download || '#'
      const changelogData = mod.changelogData || {}
      const slug = toSlug(name)

      markdown += `<details id="module-${slug}">\n`
      markdown += `<summary><a id="${name}"></a>${name}</summary>\n`
      markdown += `<div class="details-content">\n`
      markdown += `<a id="${slug}"></a>\n`

      markdown += `<strong>Description</strong>\n`
      markdown += `<p>${description}</p>\n\n`

      const versions = Object.keys(changelogData).sort((a, b) => b.localeCompare(a, undefined, { numeric: true, sensitivity: 'base' }))
      if (versions.length > 0) {
        markdown += `<strong>Changelog</strong>\n`
        markdown += `<ul>\n`
        versions.forEach(version => {
          changelogData[version].forEach(entry => {
            markdown += `  <li>${version} - ${entry}</li>\n`
          })
        })
        markdown += `</ul>\n\n`
      }

      markdown += `<div style="display: flex; justify-content: center; margin-top: 20px;">\n`
      markdown += `  <a href="${download}" style="display: inline-block; padding: 12px 24px; background-color: #007bff; color: white; text-decoration: none; border-radius: 6px; font-weight: bold; transition: background-color 0.2s;">\n`
      markdown += `    Download\n`
      markdown += `  </a>\n`
      markdown += `</div>\n`
      markdown += `</div>\n`
      markdown += `</details>\n\n`
      markdown += `---\n\n`
    })
  })

  // Write modules.md
  fs.mkdirSync(path.dirname(modulesMdPath), { recursive: true })
  fs.writeFileSync(modulesMdPath, markdown)
  console.log(`Generated modules.md at ${modulesMdPath}`)

  // Write modules/index.md
  fs.writeFileSync(modulesIndexMdPath, markdown)
  console.log(`Generated modules/index.md at ${modulesIndexMdPath}`)
}

main()
