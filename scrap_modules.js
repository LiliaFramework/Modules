const fs = require('fs')
const path = require('path')

const modulesDataPath = path.join(__dirname, 'modules_data.json')
const definitionPath = path.join(__dirname, 'documentation', 'definitions', 'module.md')
const outputPath = path.join(__dirname, 'documentation', 'modules.md')

if (!fs.existsSync(modulesDataPath)) {
  console.error('modules_data.json not found, skipping modules.md generation.')
  process.exit(1)
}

const rawData = fs.readFileSync(modulesDataPath, 'utf8')
const parsedData = JSON.parse(rawData)
const modulesList = Array.isArray(parsedData) ? parsedData : parsedData.modules || []

let details = ''
if (fs.existsSync(definitionPath)) {
  details = fs.readFileSync(definitionPath, 'utf8')
} else if (parsedData.moduleDetails) {
  details = parsedData.moduleDetails
}

function toVersionString(version) {
  if (typeof version === 'number') {
    const major = Math.floor(version / 10000)
    const minor = Math.floor(version / 100) % 100
    const patch = version % 100
    return `${major}.${minor}.${patch}`
  }
  return version
}

let output = ''

for (const moduleInfo of modulesList) {
  const {
    name = '',
    version = '',
    description = '',
    features = [],
    download = '',
    public_uniqueID = '',
  } = moduleInfo

  const versionStr = toVersionString(version)
  const versionLabel = versionStr ? ` ${versionStr}` : ''

  output += `<h2 align="center">${name}${versionLabel}</h2>\n\n`

  if (description) {
    output += `<p><strong>Description:</strong></p>\n`
    output += `<p>${description}</p>\n\n`
  }

  if (features.length) {
    output += `<p><strong>Features:</strong></p>\n<ul>\n`
    for (const feature of features) {
      output += `  <li>${feature}</li>\n`
    }
    output += `</ul>\n\n`
  }

  if (public_uniqueID) {
    const base = 'https://liliaframework.github.io/Modules/docs'

    output += `<p><strong>Libraries:</strong>\n`
    output += `  <a href="${base}/libraries/modules/${public_uniqueID}.html">Access Here</a>\n`
    output += `</p>\n\n`
    output += `<br><br>\n\n`
    output += `<p><strong>Hooks:</strong>\n`
    output += `  <a href="${base}/hooks/modules/${public_uniqueID}.html">Access Here</a>\n`
    output += `</p>\n\n`
  }

  if (download) {
    output += `<p align="center">\n`
    output += `  <a href="${download}">\n`
    output += `    <strong>Download Here</strong>\n`
    output += `  </a>\n`
    output += `</p>\n\n`
  }
}

output += details

fs.mkdirSync(path.dirname(outputPath), { recursive: true })
fs.writeFileSync(outputPath, output)
