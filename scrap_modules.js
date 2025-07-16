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

  output += `${name}${versionLabel}\n\n`

  if (description) {
    output += `Description:\n\n${description}\n\n`
  }

  if (features.length) {
    output += `Features:\n\n`
    for (const feature of features) {
      output += `${feature}\n`
    }
    output += `\n`
  }

  if (public_uniqueID) {
    const base = 'https://liliaframework.github.io/Modules/docs'
    output += `Libraries:\n\n[Access Here](${base}/libraries/modules/${public_uniqueID}.html)\n\n`
    output += `Hooks:\n\n[Access Here](${base}/hooks/modules/${public_uniqueID}.html)\n\n`
  }

  if (download) {
    output += `Download:\n\n[Download Here](${download})\n\n`
  }
}

if (details) {
  if (!output.endsWith('\n')) output += '\n'
  output += `${details.startsWith('\n') ? '' : '\n'}${details}`
}

fs.mkdirSync(path.dirname(outputPath), { recursive: true })
fs.writeFileSync(outputPath, output)
