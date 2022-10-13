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
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
  use {
	  "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use 'lervag/vimtex'
  use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}
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

g.vimtex_view_method = "zathura"


require("mason").setup()
require("mason-lspconfig").setup()
g.coq_settings = {auto_start = 'shut-up'}
local coq = require "coq"
require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities({}))
    end
}
require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
  { src = "vimtex",  short_name = "vTEX" },
  { src = "orgmode", short_name = "ORG" },

}
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
