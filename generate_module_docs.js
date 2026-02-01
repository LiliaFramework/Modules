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

  let markdown = '# List of Modules\n\n'

  const categories = ['Modules', 'Droppers']
  categories.forEach(category => {
    const mods = grouped[category]
    if (mods.length === 0 && category === 'Droppers') return

    markdown += `## ${category}\n\n`
    if (mods.length === 0) {
      markdown += 'No modules found.\n\n'
      return
    }

    mods.forEach(mod => {
      const name = mod.name || 'Unknown'
      const description = mod.description || 'No description available.'
      const features = mod.features || []
      const download = mod.download || '#'
      const sourceUrl = mod.source || ''

      // Extract folder from source URL: ../modules/{folder}/index.md
      let folder = ''
      const match = sourceUrl.match(/\/modules\/([^/]+)\//)
      if (match) {
        folder = match[1]
      }

      const changelog = folder ? getChangelog(folder) : ''

      markdown += `<details>\n<summary>${name}</summary>\n\n`
      markdown += `- **Name**: ${name}\n`
      markdown += `- **Description**: ${description}\n`

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
      } else {
        markdown += `- **Changelog**: Not available\n`
      }

      markdown += `- [Download Button](${download})\n\n`
      markdown += `</details>\n\n`
    })
  })

  // Write modules.md
  fs.mkdirSync(path.dirname(modulesMdPath), { recursive: true })
  fs.writeFileSync(modulesMdPath, markdown)
  console.log(`Generated modules.md at ${modulesMdPath}`)

  // Write modules/index.md
  let indexMarkdown = '# Modules\n\n'
  if (modules.length === 0) {
    indexMarkdown += 'No module data available. Please check back later.\n'
  } else {
    modules.forEach(mod => {
      indexMarkdown += `- [${mod.name || 'Unknown'}](${mod.source || ''})\n`
    })
  }
  fs.mkdirSync(path.dirname(modulesIndexMdPath), { recursive: true })
  fs.writeFileSync(modulesIndexMdPath, indexMarkdown)
  console.log(`Generated modules/index.md at ${modulesIndexMdPath}`)
}

main()
