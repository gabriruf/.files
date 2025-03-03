-----------------------------------
--- RUFF'S NEOVIM CONFIGURATION ---
-----------------------------------



----------------
--- Settings ---
----------------
local o = vim.o
local g = vim.g

g.loaded_perl_provider = 0
g.loaded_python_provider = 0

o.number = true
o.relativenumber = true
o.termguicolors = true
o.splitright = true
o.splitbelow = true
o.swapfile = false
o.cursorline = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.showtabline = 2



---------------
--- Plugins ---
---------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
    performance = {
        rtp = {
            paths = { "/usr/share/vim/vimfiles" }
        },
    },
    spec = {
        'nvim-lualine/lualine.nvim',
        'nvim-tree/nvim-web-devicons',
	    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	    { "Tsuzat/NeoSolarized.nvim",
	    	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	    	priority = 1000, -- make sure to load this before all the other start plugins
        	},	
        	'goolord/alpha-nvim',
        	{ 'nvim-telescope/telescope.nvim', tag = '0.1.8' },
        	{ 'nvim-lua/plenary.nvim' },
        },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})



-------------------
--- Keybindings ---
-------------------
local opts = { noremap = true, silent = true }
local key = vim.keymap.set
local builtin = require('telescope.builtin')
g.mapleader = "\\"
g.maplocalleader = "\\"

-- General
key('n', "<C-n><S-n>", ":nohlsearch<CR>", opts)
key('n', "<S-n>", "gt", opts)
key('n', "<S-b>", "gT", opts)
key('n', "<leader>l", ":Lazy<CR>", opts)
key('n', "<leader>tx", ":Tex<CR>", opts)
-- Telescope keybindings
key('n', "<leader>ff", builtin.find_files, {})
key('n', "<leader>fg", builtin.live_grep, {})
key('n', "<leader>fb", builtin.buffers, {})
key('n', "<leader>fh", builtin.help_tags, {})

