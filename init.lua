-----------------------------------------------------------------------------------------------------------------------------
-- Documentation
--
-- default data path: ~/.local/share/nvim/
-- default config path: ~/.config/nvim/init.lua
-- plugins are added to plugins array encoded as string "<githubusername>/<reponame>"
-- check for plugin updates :Lazy check
-- update plugins :Lazy update
-- install language for treesitter :TSInstall <language_to_install> (or add to treesizzer languages setup below)
-- installed treesitter parsers :TSInstallInfo
-- for clang add include paths for lsp (clangd backend) 
-- add .clangd file in path where neovim is executed with the format
-- CompileFlags:
--     Add: -I<absolute path to include directory>

-- Options
--
-- neovim options with vim.opt.option = value
-- instead of set var; set novar; now vim.opt.var = true/false
vim.opt.encoding        = "UTF-8"
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.cursorline      = true
vim.opt.title           = true
vim.opt.expandtab       = true
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4
vim.opt.foldmethod      = "syntax"

-- Keymappings
--
-- vim.api.nvim_set_keymap(mode, binding, action, option-array)
-- mode, binding and action are strings
-- empty mode string == all modes, others are i, n, v, x
-- option-array: {noremap = ..., silent = ...}
vim.api.nvim_set_keymap("", "<C-n>", ":NERDTreeToggle<CR>", {})
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

-- Plugins
--
-- Format: "<githubusername>/<reponame>"
local plugins = {
    "neovim/nvim-lspconfig", -- enable usage of language servers supporting lsp
    "nvim-treesitter/nvim-treesitter", -- live-parsing of source (treesitter) + hightlighting
    "https://github.com/ap/vim-css-color", -- color preview
    "https://github.com/joshdick/onedark.vim", -- colorscheme
    "https://github.com/preservim/nerdtree",  -- project sidebar
    "https://github.com/Xuyuanp/nerdtree-git-plugin",
    "https://github.com/ryanoasis/vim-devicons",

    -- code completion
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp", 
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
}

-- Colorscheme
--
local colorscheme = "onedark"
-----------------------------------------------------------------------------------------------------------------------------















-- bootstrap package manager (lazy)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- make sure plugins are installed via package manager
require("lazy").setup(plugins)


-- list of languages as languageservers for lsp and parsers for treesitter
local lspcfg = require "lspconfig"
local tslangs = {}


-- diff
tslangs[#tslangs+1] = "diff"
-- cmake
tslangs[#tslangs+1] = "cmake"
-- kconfig
tslangs[#tslangs+1] = "kconfig"
-- lua
tslangs[#tslangs+1] = "lua"
-- perl
tslangs[#tslangs+1] = "perl"
-- bash
tslangs[#tslangs+1] = "bash"
-- rust
tslangs[#tslangs+1] = "rust"
lspcfg.rust_analyzer.setup{}
-- regex
tslangs[#tslangs+1] = "regex"
-- toml
tslangs[#tslangs+1] = "toml"
-- yaml
tslangs[#tslangs+1] = "yaml"
-- markdown
tslangs[#tslangs+1] = "markdown"
-- python (pyright package required)
lspcfg.pyright.setup{}
tslangs[#tslangs+1] = "python"
-- C/C++ (clangd package required)
lspcfg.clangd.setup{}
tslangs[#tslangs+1] = "c"
tslangs[#tslangs+1] = "cpp"
-- makefile
tslangs[#tslangs+1] = "make"
-- markdown
tslangs[#tslangs+1] = "markdown"


-- treesitter languages setup
require("nvim-treesitter.configs").setup{
    ensure_installed = tslangs,
}

-- Vimscript-Commands
--
-- backup if vimscript is required vim.cmd("string with command")
vim.cmd("colorscheme "..colorscheme)
