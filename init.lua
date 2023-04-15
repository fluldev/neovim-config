-- Package Collection: https://github.com/rockerBOO/awesome-neovim

-- Packages
--
-- packages, semicolons are required
require "paq" {
    "https://github.com/savq/paq-nvim";

    -- lsp server package manager and lsp additions (see mason github)
    "https://github.com/williamboman/mason.nvim";
    "https://github.com/williamboman/mason-lspconfig.nvim";
    "https://github.com/neovim/nvim-lspconfig";

    -- better highlighting with treesitter
    "https://github.com/nvim-treesitter/nvim-treesitter";

    -- colorscheme
    "https://github.com/joshdick/onedark.vim";

    -- nerdtree
    "https://github.com/preservim/nerdtree";
    "https://github.com/Xuyuanp/nerdtree-git-plugin";
    "https://github.com/ryanoasis/vim-devicons";

    -- #ffaabb color preview
    "https://github.com/ap/vim-css-color";

    -- airline at the bottom
    "https://github.com/vim-airline/vim-airline";
    "https://github.com/vim-airline/vim-airline-themes";

    -- code completion
    "https://github.com/hrsh7th/cmp-vsnip";
    "https://github.com/hrsh7th/vim-vsnip";

    "https://github.com/hrsh7th/cmp-nvim-lsp";
    "https://github.com/hrsh7th/cmp-path";
    "https://github.com/hrsh7th/cmp-cmdline";
    "https://github.com/hrsh7th/nvim-cmp";
}

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

-- Global variables
--
-- global variables with vim.g.var = value
vim.g.NERDTreeQuitOnOpen = 1

-- Keymappings
--
-- vim.api.nvim_set_keymap(mode, binding, action, option-array)
-- mode, binding and action are strings
-- empty mode string == all modes, others are i, n, v, x
-- option-array: {noremap = ..., silent = ...}
vim.api.nvim_set_keymap("", "<C-n>", ":NERDTreeToggle<CR>", {})
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

-- Vimscript-Commands
--
-- backup if vimscript is required vim.cmd("string with command")
vim.cmd("colorscheme onedark")

-- Treesitter
local configs = require "nvim-treesitter.configs"
configs.setup {
-- better syntax highlighting for those languages via treesitter 
-- https://medium.com/@shaikzahid0713/treesitter-7a52f64291c8
    ensure_installed = {
        "lua",
        "python",
        "rust",
        "bash",
        "regex",
        "toml",
        "yaml",
        "markdown",
        "c",
        "cpp"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
    }
}

-- LSP setup and code completion/recommendations
--

require("mason").setup()
require("mason-lspconfig").setup()


-- Set up lspconfig.
local lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.autostart = true
local lsp_setups = {capabilities = capabilities}

lsp["clangd"].setup(lsp_setups)
lsp["pyright"].setup(lsp_setups)
lsp["rust_analyzer"].setup(lsp_setups)
lsp["sumneko_lua"].setup(lsp_setups)
lsp["bashls"].setup(lsp_setups)
lsp["texlab"].setup(lsp_setups)

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
