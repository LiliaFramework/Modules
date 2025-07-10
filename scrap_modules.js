const fs = require('fs');
const path = require('path');

const modulesPath = path.join(__dirname, 'docs', 'modules.md');
const moduleFieldsPath = path.join(__dirname, 'docs', 'definitions', 'module.md');
const outPath = path.join(__dirname, 'hi.md');

const modulesMd = fs.readFileSync(modulesPath, 'utf8');
const moduleDetails = fs.readFileSync(moduleFieldsPath, 'utf8');

const sections = modulesMd.split('\n---\n');
let output = '# Module Summary\n\n';

for (const section of sections) {
  const nameMatch = section.match(/<h2 align="center">([^<]+)<\/h2>/);
  if (!nameMatch) continue;
  const name = nameMatch[1].trim();

  const descMatch = section.match(/\*\*Description:\*\*[\s\r\n]+([\s\S]*?)\n\n\*\*Features:\*\*/);
  const desc = descMatch ? descMatch[1].trim().replace(/\n+/g, ' ') : '';

  const featuresMatch = section.match(/\*\*Features:\*\*[\s\r\n]+([\s\S]*?)\n\n<h2 align/);
  let features = [];
  if (featuresMatch) {
    features = featuresMatch[1].split(/\n+/).map(l => l.replace(/^\*\s*/, '').trim()).filter(Boolean);
  }

  const linkMatch = section.match(/<a href="([^"]+)">Download Here<\/a>/);
  const link = linkMatch ? linkMatch[1] : '';

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
