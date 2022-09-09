local g = vim.g
local o = vim.o
local fn = vim.fn
local km = vim.api.nvim_set_keymap
local cmd = vim.cmd

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use "EdenEast/nightfox.nvim"
  use {
      "williamboman/nvim-lsp-installer",
      "neovim/nvim-lspconfig",
  }
  use {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  }
  use {
    {'ms-jpq/coq_nvim', branch = 'coq'},
    {'ms-jpq/coq.artifacts', branch = 'artifacts'},
    {'ms-jpq/coq.thirdparty', branch = '3p'},
  }
  use "lukas-reineke/indent-blankline.nvim"
  use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

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
km("n", "<leader>n", ":CHADopen<cr>", { noremap = true })

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

local lsp_installer = require("nvim-lsp-installer")
g.coq_settings = {auto_start = 'shut-up'}
local coq = require "coq"
lsp_installer.on_server_ready(function(server)
  local opts = {}
  server:setup(coq.lsp_ensure_capabilities(opts))
end)

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}


require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    }
  }
