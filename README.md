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

---

## ✅ What the script does

- Checks if `~/.nanorc` and `~/.nano/` already exist
- If so, it backs them up as `~/.nanorc.saved.1`, `~/.nano.saved.1`, etc.
- Creates symbolic links:
  - `~/.nanorc → <repo>/nanorc`
  - `~/.nano   → <repo>/nano/`
- This allows you to keep configuration files versioned in Git
- To get the latest version, simply run:

```bash
cd nano-config-student
git pull
```

---

## 📁 Repository contents

- `nanorc` – main nano configuration file, including syntax settings
- `nano/` – optional syntax highlight definitions and sub-configurations
- `install.sh` – installation script that sets everything up safely

---

## 🔄 Updating the configuration

If you've linked `.nanorc` and `.nano` to this repository using the install
script, you can get future updates by running:

```bash
cd nano-config-student
git pull
```

The changes will take effect the next time you launch `nano`.

---

## 💬 Questions or suggestions?

Feel free to open an issue or fork the repository.

---

## 📜 License

MIT License – use, share, and adapt freely.

