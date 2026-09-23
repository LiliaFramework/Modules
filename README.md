<p align="center">
 <strong>Lilia Modules — Official Module Collection</strong><br/>
 A maintained collection of optional modules for extending Lilia servers with additional gameplay, utility, administration, and presentation systems.<br/>
 Each module is designed to plug into the Lilia ecosystem without requiring changes to the framework core.
</p>

<p align="center">
 <img src="https://bleonheart.github.io/Samael-Assets/lilia.png?raw=true" alt="Lilia Logo" width="220" />
</p>

<p align="center">
 <a href="https://github.com/LiliaFramework/Modules/stargazers">
  <img src="https://img.shields.io/github/stars/LiliaFramework/Modules?style=social" alt="GitHub Stars" />
 </a>
 <a href="./License">
  <img src="https://img.shields.io/badge/License-GPLv3-blue.svg" alt="GPLv3" />
 </a>
 <a href="https://liliaframework.github.io/modules/">
  <img src="https://img.shields.io/badge/Documentation-Modules-blue?logo=readthedocs&logoColor=white" alt="Module Documentation" />
 </a>
 <a href="https://discord.gg/esCRH5ckbQ">
  <img src="https://img.shields.io/badge/Discord-Join%20Chat-5865F2?logo=discord&logoColor=white" alt="Discord" />
 </a>
</p>

---

## Overview

This repository contains optional modules maintained for the Lilia framework.

Each top-level module directory is self-contained and commonly includes a `module.lua` definition together with configuration, hooks, commands, libraries, entities, UI, or other module-specific files.

Modules currently cover systems such as:

- AFK handling
- Broadcasts and chat presentation
- Captions and cinematic text
- Community commands
- Damage numbers
- Door interaction
- Flashlight behavior
- Hospitals
- HUD extensions
- Lockpicking
- NPC systems
- Radio
- Raised weapons
- Restart and map utilities
- Slots
- Steam group rewards
- War tables

The collection continues to evolve as new reusable systems are added.

## Using Modules

Choose the module you want and install it in a location loaded by your Lilia schema or server configuration.

Before enabling a module:

1. Read its `module.lua`
2. Review any `config.lua` or module-specific configuration
3. Check for dependencies or required content
4. Test it in a development environment
5. Consult the module documentation when available

Framework documentation:

https://liliaframework.github.io/modules/

## Module Structure

A typical module may look like:

```text
module-name/
├── module.lua
├── config.lua
├── commands.lua
├── hooks/
├── libraries/
└── ...
```

Not every module uses the same layout. Lilia loads module components according to the framework's module conventions.

## Development Tools

The repository includes tooling for maintaining module documentation and metadata:

- `generate_module_docs.js`
- `scrap_modules.js`

## Contributing

New modules and improvements to existing modules are welcome.

1. Fork the repository
2. Create a feature branch
3. Keep the module self-contained where practical
4. Follow Lilia framework conventions
5. Test the module against a current Lilia installation
6. Open a pull request describing its behavior and configuration

Please review [Code_Of_Conduct.md](./Code_Of_Conduct.md) before contributing.

## License

The module collection is distributed under the GNU General Public License v3.0.

See [License](./License) for details.