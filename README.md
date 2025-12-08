# homebrew-scrap

Homebrew tap for [Scrap](https://github.com/ZacharyAnderson/Scrap) - a fast, interactive note-taking CLI tool.

## Installation

```bash
# Add the tap
brew tap zacharyanderson/scrap

# Install Scrap
brew install scrap
```

Or install directly:

```bash
brew install zacharyanderson/scrap/scrap
```

## What gets installed

- The `scrap` binary
- SQLite database initialized at `~/.scrap/scrap.db` with notes table and triggers
- Dependencies: `fzf` and `bat`

## Usage

After installation, run:

```bash
scrap help
```

For more information, see the [main Scrap repository](https://github.com/ZacharyAnderson/Scrap).
