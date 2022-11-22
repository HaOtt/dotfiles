local g = vim.g
local o = vim.o
local fn = vim.fn
local km = vim.api.nvim_set_keymap
local cmd = vim.cmd

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use "EdenEast/nightfox.nvim"
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  }

  use {
	  "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use 'lervag/vimtex'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-orgmode/orgmode'}

  if packer_bootstrap then
    require('packer').sync()
  end
end)

o.mouse = "a"

g.mapleader = ","
g.maplocalleader = "\\"

km("n", "<leader>ev", ":vsplit $MYVIMRC<cr>", { noremap = true })
km("n", "<leader>sv", ":source $MYVIMRC<cr>", { noremap = true })


km("n", "<leader>f", ":Telescope find_files<cr>", { noremap = true })
km("n", "<leader>g", ":Telescope live_grep<cr>", { noremap = true })
km("n", "<leader>b", ":Telescope buffers<cr>", { noremap = true })
km("n", "<leader>n", ":NvimTreeToggle<cr>", { noremap = true })

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

km("n", "<C-s>", ":write<cr>", { noremap = true })
km("v", "<C-s>", "<C-c>:write<cr>", { noremap = true })
km("i", "<C-s>", "<Esc>:write<cr>", { noremap = true })
km("o", "<C-s>", "<Esc>:write<cr>", { noremap = true })

o.number = true
o.encoding = "utf-8"
o.backup = false
o.swapfile = false
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.clipboard = "unnamedplus"

o.termguicolors = true
g.base16colorspace = 256
cmd('colorscheme nightfox')

g.vimtex_view_method = "zathura"

require("nvim-tree").setup()

local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

require('orgmode').setup_ts_grammar()
require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = {'org'},
    }
  }
require('orgmode').setup({
  org_agenda_files = {'~/Nextcloud/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Nextcloud/org/refile.org',
})
