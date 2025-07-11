const fs = require('fs');
const path = require('path');
const modulesDataPath = path.join(__dirname, 'modules_data.json');
const definitionPath = path.join(__dirname, 'documentation', 'definitions', 'module.md');
const outputPath = path.join(__dirname, 'documentation', 'modules.md');

const outputDir = path.dirname(outputPath);
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

if (!fs.existsSync(modulesDataPath)) {
  console.error('modules_data.json not found, skipping modules.md generation.');
  process.exit(1);
}

const rawData = fs.readFileSync(modulesDataPath, 'utf8');
const parsedData = JSON.parse(rawData);
const modulesList = Array.isArray(parsedData) ? parsedData : parsedData.modules || [];

let details = '';
if (fs.existsSync(definitionPath)) {
  details = fs.readFileSync(definitionPath, 'utf8');
} else if (parsedData.moduleDetails) {
  details = parsedData.moduleDetails;
} else {
  console.warn(`${definitionPath} not found and no moduleDetails in JSON.`);
}

let output = '# Optional Modules\n\n';

for (const module of modulesList) {
  const {
    name = '',
    version = '',
    description = '',
    features = [],
    download = '',
  } = module;
  const versionLabel = version ? ` ${version}` : '';
  output += `<h2 align="center">${name}${versionLabel}</h2>\n\n`;
  if (description) output += `**Description:** ${description}\n\n`;
  if (features.length) {
    output += '**Features:**\n';
    for (const feature of features) output += `- ${feature}\n`;
    output += '\n';
  }
  if (download) {
    output += `<p align="center"><a href="${download}">Download Here</a></p>\n\n`;
  }
}

output += '---\n\n' + details;
fs.writeFileSync(outputPath, output);
