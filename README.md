# homebrew-scrap

Homebrew tap for [scrap](https://github.com/ZacharyAnderson/scrap-rs) - a CLI note-taking app with a TUI, tag-based organization, and LLM-powered summaries.

## Installation

```bash
brew tap zacharyanderson/scrap
brew install scrap
```

Or install directly:

```bash
brew install zacharyanderson/scrap/scrap
```

## What gets installed

- The `scrap` binary (built from source with Cargo)
- SQLite database initialized at `~/.scrap/scrap.db` on first run

## Optional setup

For the summarize feature, set your Anthropic API key:

```bash
export ANTHROPIC_API_KEY=your_key_here
```

## Usage

```bash
scrap        # Launch the TUI
scrap --help # See all commands
```

For more information, see the [scrap-rs repository](https://github.com/ZacharyAnderson/scrap-rs).
