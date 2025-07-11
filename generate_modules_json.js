const fs = require('fs');
const path = require('path');

const modulesDir = __dirname;
const outPath = path.join(__dirname, 'modules.json');

function parseArray(str) {
  if (!str) return [];
  str = str.trim();
  if (str.startsWith('{') && str.endsWith('}')) {
    // remove braces
    str = str.slice(1, -1);
  }
  // split by comma
  return str
    .split(/,\s*/)
    .map(s => s.replace(/^"|"$/g, '').trim())
    .filter(Boolean);
}

function extract(regex, text) {
  const m = text.match(regex);
  return m ? m[1] : '';
}

const modules = [];
for (const entry of fs.readdirSync(modulesDir, { withFileTypes: true })) {
  if (!entry.isDirectory()) continue;
  const modulePath = path.join(modulesDir, entry.name, 'module.lua');
  if (!fs.existsSync(modulePath)) continue;
  const data = fs.readFileSync(modulePath, 'utf8');
  const name = extract(/MODULE\.name\s*=\s*"([^"]*)"/, data);
  const author = extract(/MODULE\.author\s*=\s*"([^"]*)"/, data);
  const discord = extract(/MODULE\.discord\s*=\s*"([^"]*)"/, data);
  const desc = extract(/MODULE\.desc\s*=\s*"([^"]*)"/, data);
  const version = extract(/MODULE\.version\s*=\s*"([^"]*)"/, data) || '1.0';
  const featuresRaw = extract(/MODULE\.Features\s*=\s*(\{[^\}]*\}|"[^"]*")/, data);
  const workshopRaw = extract(/MODULE\.WorkshopContent\s*=\s*(\{[^\}]*\}|"[^"]*")/, data);
  const features = parseArray(featuresRaw);
  const workshop = parseArray(workshopRaw);
  const folder = entry.name;
  const download = `https://github.com/LiliaFramework/Modules/raw/refs/heads/gh-pages/Downloads/${folder}.zip`;
  const source = `https://liliaframework.github.io/Modules/${folder}.html`;
  modules.push({
    name,
    author,
    discord,
    description: desc,
    version,
    download,
    source,
    public_uniqueID: folder,
    features,
    workshop
  });
}
fs.writeFileSync(outPath, JSON.stringify(modules, null, 2));
