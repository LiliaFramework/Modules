const fs = require('fs')
const path = require('path')

const documentationDir = path.join(__dirname, 'documentation')
const docsModulesDir = path.join(documentationDir, 'docs', 'modules')
const modulesJsonPath = path.join(documentationDir, 'modules.json')
const modulesMdPath = path.join(documentationDir, 'docs', 'modules.md')
const modulesIndexMdPath = path.join(docsModulesDir, 'index.md')

function toSlug(name) {
  return String(name)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-$/g, '')
}

function stripH1(content) {
  return content.replace(/^#\s+.*\n?/, '').trim()
}

function stripRealmIdentifiers(content) {
  if (!content) return ''
  return content
    .replace(/<div class="realm-[^"]+">/g, '')
    .replace(/<div class="realm-header">[^<]+<\/div>/g, '')
    .replace(/<div class="details-content">/g, '')
    .replace(/<\/div>/g, (match, offset, str) => {
      // Basic check to only remove divs that were likely our wrappers
      // This is a bit naive but works for the common case
      return ''
    })
    .trim()
}

function stripWrappers(content) {
  // More robust stripping of our specific containers
  let cleaned = stripH1(content)
  cleaned = cleaned.replace(/<div class="realm-[^"]+">/g, '')
  cleaned = cleaned.replace(/<div class="realm-header">[^<]*<\/div>/g, '')
  cleaned = cleaned.replace(/<div class="details-content">/g, '')
  cleaned = cleaned.replace(/<\/div>/g, '')
  return cleaned.trim()
}

function getChangelog(folder) {
  const changelogPath = path.join(docsModulesDir, folder, 'changelog.md')
  if (fs.existsSync(changelogPath)) {
    try {
      return fs.readFileSync(changelogPath, 'utf8')
    } catch (err) {
      console.error(`Failed to read changelog for ${folder}:`, err)
    }
  }
  return ''
}

function getAbout(folder) {
  const aboutPath = path.join(docsModulesDir, folder, 'index.md')
  if (fs.existsSync(aboutPath)) {
    try {
      return fs.readFileSync(aboutPath, 'utf8')
    } catch (err) {
      console.error(`Failed to read about for ${folder}:`, err)
    }
  }
  return ''
}

function main() {
  if (!fs.existsSync(modulesJsonPath)) {
    console.error('modules.json not found, skipping modules.md generation.')
    process.exit(1)
  }

  let modules = []
  try {
    modules = JSON.parse(fs.readFileSync(modulesJsonPath, 'utf8'))
  } catch (err) {
    console.error('Error parsing modules.json:', err)
    process.exit(1)
  }

  if (!Array.isArray(modules)) {
    console.error('modules.json is not an array.')
    process.exit(1)
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
      const features = mod.features || []
      const download = mod.download || '#'
      const folder = mod.folder || ''
      const slug = toSlug(name)

      const about = folder ? getAbout(folder) : ''
      const changelog = folder ? getChangelog(folder) : ''

      markdown += `<details id="${slug}">\n<summary>${name}</summary>\n\n`

      if (about) {
        markdown += `${stripWrappers(about)}\n\n`
      } else {
        markdown += `- **Description**: ${description}\n`
      }

      if (features.length > 0) {
        markdown += `- **Main Features**:\n`
        features.forEach(f => {
          markdown += `    - ${f}\n`
        })
      }

      if (changelog) {
        markdown += `- <details><summary>Changelog</summary>\n\n`
        markdown += `${changelog}\n\n`
        markdown += `</details>\n`
      }

      markdown += `- [Download Button](${download})\n\n`
      markdown += `</details>\n\n`
    })
  })

  // Write modules.md
  fs.mkdirSync(path.dirname(modulesMdPath), { recursive: true })
  fs.writeFileSync(modulesMdPath, markdown)
  console.log(`Generated modules.md at ${modulesMdPath}`)

  // Write modules/index.md (Same content as modules.md now)
  fs.mkdirSync(path.dirname(modulesIndexMdPath), { recursive: true })
  fs.writeFileSync(modulesIndexMdPath, markdown)
  console.log(`Generated modules/index.md at ${modulesIndexMdPath}`)
}

main()
