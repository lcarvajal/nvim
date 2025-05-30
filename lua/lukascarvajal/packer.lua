-- This file can be loaded by calling `lua require('plugins')` from your init.vim

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Colorscheme
  use({
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme('gruvbox-material')
    end
  })

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

  -- Git
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'

  -- Mason: manages LSP, DAP, linters, formatters installations
use { "williamboman/mason.nvim" }
use { "williamboman/mason-lspconfig.nvim" }

use {
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  }
}


end)


