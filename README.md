# nano configuration for students

This repository provides a clean and student-friendly `nano` configuration,
including syntax highlighting and sensible defaults. It can be easily installed
and updated, while safely preserving any existing user configuration.

---

## 📦 Installation

### 1. Clone and install (recommended)

```bash
git clone https://github.com/michael-lehn/nano-config.git
cd nano-config
./install.sh
```

### 2. Alternatively, install directly using `curl`

```bash
curl -fsSL https://raw.githubusercontent.com/michael-lehn/nano-config/main/install.sh | bash
```

If run this way, the repository will be cloned into `~/.nano-config` and
symbolic links will be created to point to that folder.

---

## ✅ What the install script does

- Checks if `~/.nanorc` and `~/.nano/` already exist
- If so, backs them up as `~/.nanorc.saved.1`, `~/.nano.saved.1`, etc.
- Creates symbolic links:
  - `~/.nanorc → ~/.nano-config/nanorc`
  - `~/.nano   → ~/.nano-config/nano/`
- Allows updating your configuration by running:

```bash
cd ~/.nano-config
git pull
```

---

## ❌ Uninstallation

You can remove the configuration safely using:

```bash
curl -fsSL https://raw.githubusercontent.com/michael-lehn/nano-config/main/uninstall.sh | bash
```

Or, if you cloned the repository manually:

```bash
cd nano-config
./uninstall.sh
```

The uninstall script will:

- Remove the symbolic links
- Ask whether to restore the last saved backup
- If run via `curl`, it will also ask whether to delete the `~/.nano-config`
  directory

---

## 📁 Repository contents

- `nanorc` – main nano configuration file, including syntax settings
- `nano/` – optional syntax highlight definitions and sub-configurations
- `install.sh` – safe installer with backup logic and multilingual support
- `uninstall.sh` – safe uninstaller with optional cleanup

---

## 💬 Questions or suggestions?

Feel free to open an issue or fork the repository.

---

## 📜 License

MIT License – use, share, and adapt freely.

