const fs = require('fs');
const path = require('path');

const jsonPath = path.join(__dirname, 'modules.json');
const moduleFieldsPath = path.join(__dirname, 'docs', 'definitions', 'module.md');
const outPath = path.join(__dirname, 'hi.md');

if (!fs.existsSync(jsonPath)) {
  console.error('modules.json not found, skipping hi.md generation.');
  process.exit(1);
}

const modules = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));
const moduleDetails = fs.readFileSync(moduleFieldsPath, 'utf8');

let output = '# Module Summary\n\n';

for (const mod of modules) {
  const name = mod.name || '';
  const desc = mod.description || '';
  const features = Array.isArray(mod.features) ? mod.features : [];
  const link = mod.download || '';

  output += `## ${name}\n\n`;
  if (desc) output += `**Description:** ${desc}\n\n`;
  if (features.length) {
    output += '**Features:**\n';
    for (const f of features) output += `- ${f}\n`;
    output += '\n';
  }
  if (link) output += `**Download:** ${link}\n\n`;
}

output += '\n---\n\n';
output += moduleDetails;

fs.writeFileSync(outPath, output);
