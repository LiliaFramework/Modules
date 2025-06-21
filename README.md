# Lilia – Gameplay Extensions

A collection of **gameplay extension modules** for the Lilia framework—drop-in scripts that add new mechanics, UI elements, and systems with minimal setup.

---

## 📥 Downloading Addons

All official gameplay extensions (addons) for Lilia can be browsed and downloaded here:  
[https://liliaframework.github.io/Modules/](https://liliaframework.github.io/Modules/)

Simply pick the modules you want, clone or download them into your `lilia/modules/` folder, and load them in your schema—no extra setup required.

---

## ⚙️ Module Configuration

### 1. Modules with a `config.lua`

* **Location:** `lilia/modules/<module_name>/config.lua`
* **How to override:**

  1. Copy the module’s `config.lua` into your schema’s `config/` folder.
  2. Edit values (cooldowns, spawn rates, UI positions, etc.) directly in the file.
  3. Restart the server to apply changes.

### 2. Modules without a `config.lua`

* **In-Game Configuration:**

  * These modules expose their settings via the f1 settings tab.
  * Changes take effect immediately or after a map restart, depending on the module.

> 💡 *Tip:* If you’re not sure whether a module has a `config.lua`, take a look in its folder under `lilia/modules/<module_name>/`. If there’s no `config.lua`, search for a “Settings” section in its README or test the in-game console (`?` → find `lilia_<module>`).

---

## 💡 Contributing

We welcome code contributions, documentation improvements, and feedback:

1. Fork the repository  
2. Create a feature branch  
3. Submit a pull request  

Your contributions help build a richer, more stable RP experience!

---

## 🤝 Support

Need help or want to connect with the community?
Join us on Discord:
[https://discord.gg/52MSnh39vw](https://discord.gg/52MSnh39vw)

---
