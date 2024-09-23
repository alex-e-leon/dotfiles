-- Setup lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
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
--
-- Set leader to space
vim.g.mapleader = " "

--Install plugins
require("lazy").setup({
  'junegunn/vim-easy-align',
  { 'jistr/vim-nerdtree-tabs', dependencies = { 'scrooloose/nerdtree' } },
  'scrooloose/nerdcommenter',
  { 'vim-scripts/loremipsum',  on = 'Loremipsum' },
  'shime/vim-livedown',

  -- Git
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',

  -- Autocomplete
  { 'hrsh7th/nvim-cmp',      dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' } },

  -- LSP + linting
  { 'neovim/nvim-lspconfig', dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' } },

  -- statusline
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',

  -- Better vim search highlighting
  'romainl/vim-cool',

  -- FZF search
  { 'junegunn/fzf.vim',                dependencies = { 'junegunn/fzf' } },

  -- Syntax highlighting
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Better folding
  { 'kevinhwang91/nvim-ufo',           dependencies = { 'kevinhwang91/promise-async' } },

  -- color schemes
  'AlessandroYorba/Despacio',
  -- 'mbbill/vim-seattle', 'AlessandroYorba/Sierra','thewatts/wattslandia', 'jordwalke/flatlandia'
}, {})

-- Configure colorscheme
vim.o.termguicolors = true
vim.api.nvim_command('colorscheme despacio')

-- Cursor
vim.o.relativenumber = true

-- setup treesitter
require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "css", "html", "json", "javascript", "typescript", "tsx", "graphql", "markdown", "markdown_inline", "diff", "gitignore", "git_config", "gitcommit", "git_rebase", "regex", "yaml", "lua" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  highlight = { enable = true },
}

-- config autocomplete
local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<S-TAB>'] = cmp.mapping.select_prev_item(),       -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<TAB>'] = cmp.mapping.select_next_item(),         -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Tell the server the capability of foldingRange for UFO
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- setup LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'vtsls',
    'eslint',
    'html',
    'cssls',
    'cssmodules_ls',
    'css_variables',
    'dockerls',
    'graphql',
    'lua_ls',
    'jsonls',
    'marksman',
    'mdx_analyzer',
    'stylelint_lsp',
  },
  automatic_installation = true,
})

local lspconfig = require('lspconfig')
lspconfig.vtsls.setup { capabilities = capabilities, settings = {
  javascript = { suggestionActions = { enabled = false } },
  typescript = { suggestionActions = { enabled = false } },
} }
lspconfig.eslint.setup { capabilities = capabilities }
lspconfig.html.setup { capabilities = capabilities }
lspconfig.cssmodules_ls.setup { capabilities = capabilities }
-- disable css validation because it conflicts with stylelint + some css modules features, but keep it for completion
lspconfig.cssls.setup { capabilities = capabilities, settings = { css = { validate = false } } }
lspconfig.css_variables.setup { capabilities = capabilities }
lspconfig.graphql.setup { capabilities = capabilities }
lspconfig.jsonls.setup { capabilities = capabilities }
lspconfig.dockerls.setup { capabilities = capabilities }
lspconfig.lua_ls.setup { capabilities = capabilities, settings = { Lua = { diagnostics = { globals = { 'vim' } } } } }
lspconfig.marksman.setup { capabilities = capabilities }
lspconfig.mdx_analyzer.setup { capabilities = capabilities }
lspconfig.stylelint_lsp.setup { capabilities = capabilities }

vim.keymap.set('n', 'K', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings. See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local eslintOrPrevEslint = client.name == 'eslint'
    for _, client in pairs(vim.lsp.buf_get_clients()) do
      if client.name == 'eslint' then eslintOrPrevEslint = true end
    end

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<LEADER>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Leader>f', function()
      if eslintOrPrevEslint then
        vim.cmd('EslintFixAll')
      else
        vim.lsp.buf.format { async = true }
      end
    end, opts)
  end,
})

-- configure lualine
local custom_fname = require('lualine.components.filename'):extend()
local highlight = require 'lualine.highlight'

local default_status_colors = { saved = nil, modified = 63 }

function custom_fname:init(options)
  custom_fname.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      { bg = default_status_colors.saved }, 'filename_status_saved', self.options),
    modified = highlight.create_component_highlight_group(
      { bg = default_status_colors.modified }, 'filename_status_modified', self.options),
  }
  if self.options.color == nil then self.options.color = '' end
end

function custom_fname:update_status()
  local data = custom_fname.super.update_status(self)
  data = highlight.component_format_highlight(vim.bo.modified
    and self.status_colors.modified
    or self.status_colors.saved) .. data
  return data
end

require('lualine').setup({
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { custom_fname },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location', 'searchcount' },
  }
})

-- configure UFO
vim.o.foldcolumn = '1' -- sets how many columns show folds
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = false
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local ufo = require('ufo')
ufo.setup()

--Change updatetime from 4s to 250ms to make gitgutter more responsive
vim.o.updatetime = 250

-- Show line numbers
vim.o.number = true

--Prevent vim re-rendering during macros
vim.o.lazyredraw = true

-- Set OSX system clipboard to work in vim
vim.o.clipboard = 'unnamed'

-- Set swapfile directory to home
vim.o.directory = vim.fn.expand('$HOME/.local/share/nvim/swap/')

-- Detect .md files as Markdown
vim.api.nvim_command('autocmd BufNewFile,BufReadPost *.md set filetype=markdown')

-- Nerdtree config
vim.g.NERDTreeWinSize = 40

-- Tabs
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.list = true
vim.o.listchars = 'tab:>-'

-- Configure livedown
vim.g.livedown_port = 1227

-- Configure extra space for comments
vim.g.NERDSpaceDelims = 1

--Configure fzf colors
vim.g.fzf_colors = {
  fg = { 'fg', 'Normal' },
  bg = { 'bg', 'Normal' },
  hl = { 'fg', 'Comment' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
  ['hl+'] = { 'fg', 'Statement' },
  info = { 'fg', 'PreProc' },
  border = { 'fg', 'Ignore' },
  prompt = { 'fg', 'Conditional' },
  pointer = { 'fg', 'Exception' },
  marker = { 'fg', 'Keyword' },
  spinner = { 'fg', 'Label' },
  header = { 'fg', 'Comment' }
}
vim.api.nvim_create_user_command('Rg',
  "call fzf#vim#grep('rg --column --sort path --line-number --no-heading --color=always --colors \"path:fg:215,135,95\" --colors \"line:fg:128,128,128\" --smart-case '.shellescape(<q-args>), 1, { 'options': '--color hl:223,hl+:222 --delimiter : --nth 4..' }, 0)",
  { bang = true, nargs = "*" })

-- Custom mappings
-- Leader+p fzf
vim.keymap.set('', '<Leader>p', ':FZF<CR>')
-- Leader+/ ripgrep
vim.keymap.set('', '<Leader>/', ':Rg<CR>')
-- Leader+c Toggle comments
vim.keymap.set('', '<C-c>', ':call nerdcommenter#Comment(0,"toggle")<CR>')
-- Leader+n Toggle file view
vim.keymap.set('', '<Leader>n', '<plug>NERDTreeTabsToggle<CR>')
-- Go to current file
vim.keymap.set('', '<Leader>o', ':NERDTreeFind<CR>')
-- Preview markdown files
vim.keymap.set('', '<Leader>l', ':LivedownToggle<CR>')
-- Move vertically by visual line
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', '[', vim.diagnostic.goto_next)
vim.keymap.set('n', ']', vim.diagnostic.goto_prev)

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
