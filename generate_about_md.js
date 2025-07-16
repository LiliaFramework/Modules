const fs = require('fs');
const path = require('path');

const modulesPath = path.join(__dirname, 'modules.json');

if (!fs.existsSync(modulesPath)) {
  console.error('modules.json not found, aborting about.md generation.');
  process.exit(1);
}

let modules;
try {
  const raw = fs.readFileSync(modulesPath, 'utf8');
  modules = JSON.parse(raw);
} catch (err) {
  console.error('Failed to read or parse modules.json:', err);
  process.exit(1);
}

if (!Array.isArray(modules)) {
  console.error('modules.json must contain an array of modules.');
  process.exit(1);
}

for (const mod of modules) {
  const id = mod.public_uniqueID || '';
  if (!id) continue;
  const dest = path.join(__dirname, 'documentation', 'docs', 'optional_modules', id);
  fs.mkdirSync(dest, { recursive: true });

  const lines = [];
  lines.push(`# ${mod.name || ''}`);
  lines.push('');
  if (mod.version) lines.push(`**Version:** ${mod.version}  `);
  if (mod.author) lines.push(`**Author:** ${mod.author}  `);
  if (mod.discord) lines.push(`**Discord:** ${mod.discord}  `);
  if (mod.description) {
    lines.push('');
    lines.push(mod.description);
    lines.push('');
  }
  if (Array.isArray(mod.features) && mod.features.length) {
    lines.push('## Features');
    lines.push('');
    for (const feat of mod.features) {
      lines.push(`- ${feat}`);
    }
    lines.push('');
  }
  if (Array.isArray(mod.workshop) && mod.workshop.length) {
    lines.push('## Workshop Content');
    lines.push('');
    for (const item of mod.workshop) {
      lines.push(`- ${item}`);
    }
    lines.push('');
  }
  if (mod.download) lines.push(`[Download](${mod.download})`);

  fs.writeFileSync(path.join(dest, 'about.md'), lines.join('\n'));
}

console.log('about.md files generated.');
