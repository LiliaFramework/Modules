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

  // Match version keys like ["1.0"] = or 1.0 = or ["Version 1.0"] =
  const keyRegex = /(?:\["|')?([^"'\]]+)(?:"'\])?\s*=\s*/g
  let match
  const versions = []

  while ((match = keyRegex.exec(content)) !== null) {
    versions.push({
      version: match[1],
      valueStart: match.index + match[0].length,
      matchStart: match.index
    })
  }

  for (let i = 0; i < versions.length; i++) {
    const v = versions[i]
    // The value ends either at the start of the next key or the end of the string
    const valueEnd = versions[i + 1] ? versions[i + 1].matchStart : content.length
    let rawValue = content.substring(v.valueStart, valueEnd).trim()

    // Remove trailing comma if it exists (common in Lua tables)
    if (rawValue.endsWith(',')) {
      rawValue = rawValue.substring(0, rawValue.length - 1).trim()
    }

    if (rawValue.startsWith('{')) {
      let braceCount = 0
      let tableContent = ""
      for (let j = 0; j < rawValue.length; j++) {
        if (rawValue[j] === '{') braceCount++
        if (rawValue[j] === '}') braceCount--
        if (braceCount === 0) {
          tableContent = rawValue.substring(1, j)
          break
        }
      }
      changelog[v.version] = parseLuaTable(tableContent)
    } else {
      const stringMatch = rawValue.match(/["']([^"']*)["']/)
      if (stringMatch) {
        changelog[v.version] = [stringMatch[1]]
      }
    }
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

  // Improved changelog extraction to handle nested braces
  const changelogStartMatch = content.match(/MODULE\.Changelog\s*=\s*\{/)
  if (changelogStartMatch) {
    const startIndex = changelogStartMatch.index + changelogStartMatch[0].length - 1
    let braceCount = 0
    let changelogContent = ""

    for (let i = startIndex; i < content.length; i++) {
      const char = content[i]
      if (char === '{') braceCount++
      if (char === '}') braceCount--

      if (braceCount === 0) {
        changelogContent = content.substring(startIndex + 1, i)
        break
      }
    }
    metadata.changelogData = parseChangelog(changelogContent)
  } else {
    metadata.changelogData = {}
  }

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

      // Main module block starts here
      markdown += `<details class="realm-shared" id="module-${slug}">\n`
      markdown += `<summary><a id="${name}"></a>${name}</summary>\n`
      markdown += `<div class="details-content">\n`
      markdown += `<a id="${slug}"></a>\n`

      // 1. Description Section
      markdown += `<h3 style="margin-bottom: 5px;">Description</h3>\n`
      markdown += `<div style="margin-left: 20px; margin-bottom: 20px;">\n`
      markdown += `  <p>${description.trim()}</p>\n`
      markdown += `</div>\n\n`

      // 2. Changelog Section
      const versions = Object.keys(changelogData).sort((a, b) => b.localeCompare(a, undefined, { numeric: true, sensitivity: 'base' }))
      if (versions.length > 0) {
        markdown += `<h3 style="margin-bottom: 5px;">Changelog</h3>\n`
        markdown += `<div style="margin-left: 20px;">\n`

        versions.forEach((version) => {
          const vSlug = toSlug(version) || 'v'
          markdown += `  <details class="realm-shared" id="changelog-${slug}-${vSlug}">\n`
          markdown += `    <summary>Version ${version}</summary>\n`
          markdown += `    <div class="details-content" style="margin-left: 20px;">\n`
          markdown += `      <ul>\n`

          const entries = changelogData[version] || []
          entries.forEach(entry => {
            markdown += `        <li>${String(entry).trim()}</li>\n`
          })

          markdown += `      </ul>\n`
          markdown += `    </div>\n`
          markdown += `  </details>\n`
        })
        markdown += `</div>\n\n`
      }

      // 3. Download Section
      markdown += `<div style="display: flex; justify-content: center; margin-top: 20px;">\n`
      markdown += `  <a href="${download}" style="display: inline-block; padding: 12px 24px; background-color: #007bff; color: white; text-decoration: none; border-radius: 6px; font-weight: bold; transition: background-color 0.2s;">\n`
      markdown += `    Download\n`
      markdown += `  </a>\n`
      markdown += `</div>\n`

      markdown += `</div>\n` // End details-content
      markdown += `</details>\n\n` // End module toggle

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
