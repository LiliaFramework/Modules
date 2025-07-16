const { existsSync, mkdirSync, readFileSync, writeFileSync } = require('fs');
const { join, dirname } = require('path');

const dataPath = join(__dirname, 'modules_data.json');
const defPath  = join(__dirname, 'documentation', 'definitions', 'module.md');
const outPath  = join(__dirname, 'documentation', 'modules.md');

if (!existsSync(dataPath)) {
  console.error('modules_data.json not found, skipping modules.md generation.');
  process.exit(1);
}

const raw      = readFileSync(dataPath, 'utf8');
const parsed   = JSON.parse(raw);
const list     = Array.isArray(parsed) ? parsed : parsed.modules || [];
const details  = existsSync(defPath) ? readFileSync(defPath, 'utf8') : parsed.moduleDetails || '';

const outDir = dirname(outPath);
if (!existsSync(outDir)) mkdirSync(outDir, { recursive: true });

const toVersion = v => {
  if (typeof v === 'number') {
    const major = Math.floor(v / 10000);
    const minor = Math.floor(v / 100) % 100;
    const patch = v % 100;
    return `${major}.${minor}.${patch}`;
  }
  return v;
};

let md = '# Optional Modules\n\n';

for (const {
  name = '',
  version = '',
  description = '',
  features = [],
  download = '',
  public_uniqueID = ''
} of list) {
  const ver = toVersion(version);
  md += `<h2 align="center">${name}${ver ? ` ${ver}` : ''}</h2>\n\n`;
  if (description) md += `**Description:** ${description}\n\n`;
  if (features.length) {
    md += '**Features:**\n\n';
    for (const f of features) md += `- ${f}\n`;
    md += '\n';
  }
  if (public_uniqueID) {
    const base = 'https://liliaframework.github.io/Modules/docs';
    md += `<p align="center"><a href="${base}/libraries/modules/${public_uniqueID}.html">Libraries</a> | <a href="${base}/hooks/modules/${public_uniqueID}.html">Hooks</a></p>\n\n`;
  }
  if (download) md += `<h1 align="center"><a href="${download}">DOWNLOAD HERE</a></h1>\n\n`;
}

md += '---\n\n' + details;

writeFileSync(outPath, md);