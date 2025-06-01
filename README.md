# Neovim Config

Lukas's personalized Neovim config.

- Package manager: [Packer](https://github.com/wbthomason/packer.nvim)
- Theme: [Gruvbox Material](https://github.com/sainnhe/gruvbox-material)

# Setup

## Dependencies

- [ripgrep](https://github.com/BurntSushi/ripgrep)

## Adding new plugins

1. Add plugin to `lua/lukascarvajal/packer.lua`
2. Run `:so` and `:PackerSync`
3. Add config to `after/plugin/<plugin_name>.lua`

## Adding LSP support for a new language

1. Use `:Mavin` to open the UI and find the language server
2. Install with `:MavinInstall <langage_server>`
3. Add the file under `nvim/after/plugin/lsp.lua`
