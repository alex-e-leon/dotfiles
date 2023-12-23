-- Setup lazy.nvim package manager
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

--Install plugins 
require("lazy").setup({
  'junegunn/vim-easy-align',
  'scrooloose/nerdtree',
  'jistr/vim-nerdtree-tabs',
  'scrooloose/nerdcommenter',
  {'vim-scripts/loremipsum', on = 'Loremipsum'},
  'shime/vim-livedown',

  -- Git
  'tpope/vim-fugitive',
  'airblade/vim-gitgutter',

  -- Autocomplete
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',

  -- LSP + linting
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',

  -- statusline
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',

  -- Better vim search highlighting
  'romainl/vim-cool',
  {'junegunn/fzf.vim', dependencies = {'junegunn/fzf'}},

  -- Syntax highlighting
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

  -- color schemes
  'AlessandroYorba/Despacio',
  -- 'mbbill/vim-seattle', 'AlessandroYorba/Sierra','thewatts/wattslandia', 'jordwalke/flatlandia'
}, {})

-- Configure colorscheme
vim.o.termguicolors=true
vim.api.nvim_command('colorscheme despacio')

-- Cursor
vim.o.nocursorcolumn=true
vim.o.nocursorline=true
vim.o.relativenumber=true

-- setup treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {"lua", "diff", "gitignore", "gitcommit", "git_rebase", "css", "html", "json", "javascript", "typescript", "tsx", "graphql", "markdown", "markdown_inline", "regex", "terraform" },
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
    ['<S-TAB>'] = cmp.mapping.select_prev_item(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<TAB>'] = cmp.mapping.select_next_item(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- setup LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'html',
    'cssmodules_ls',
    'cssls',
    'graphql',
    'jsonls',
    'marksman',
    'mdx_analyzer',
    'stylelint_lsp',
    'tflint',
    'terraformls',
  },
  automatic_installation = true,
})
require('lspconfig').tsserver.setup({ init_options = { preferences = { disableSuggestions = true }}})
require('lspconfig').eslint.setup({capabilities = capabilities})
require('lspconfig').html.setup {capabilities = capabilities}
require('lspconfig').cssmodules_ls.setup {capabilities = capabilities}
-- disable css validation because it conflicts with stylelint + some css modules features, but keep it for completion
require('lspconfig').cssls.setup {capabilities = capabilities, settings = { css = { validate = false }}}
require('lspconfig').graphql.setup {capabilities = capabilities}
require('lspconfig').jsonls.setup {capabilities = capabilities}
require('lspconfig').marksman.setup {capabilities = capabilities}
require('lspconfig').mdx_analyzer.setup {capabilities = capabilities}
require('lspconfig').stylelint_lsp.setup {capabilities = capabilities}
require('lspconfig').tflint.setup {capabilities = capabilities}
require('lspconfig').terraformls.setup {capabilities = capabilities}

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
local highlight = require'lualine.highlight'

local default_status_colors = { saved = nil, modified = 63}

function custom_fname:init(options)
  custom_fname.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      {bg = default_status_colors.saved}, 'filename_status_saved', self.options),
    modified = highlight.create_component_highlight_group(
      {bg = default_status_colors.modified}, 'filename_status_modified', self.options),
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
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {custom_fname},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location', 'searchcount'},
  }
})

--Change updatetime from 4s to 250ms to make gitgutter more responsive
vim.o.updatetime=250

-- Show line numbers
vim.o.number=true

-- Set leader to space
vim.g.mapleader=" "

--Prevent vim re-rendering during macros
vim.o.lazyredraw=true

-- Set OSX system clipboard to work in vim
vim.o.clipboard='unnamed'

-- Set swapfile directory to home
vim.o.directory=vim.fn.expand('$HOME/.local/share/nvim/swap/')

-- Detect .md files as Markdown
vim.api.nvim_command('autocmd BufNewFile,BufReadPost *.md set filetype=markdown')

-- Nerdtree config
vim.g.NERDTreeWinSize = 40

-- Tabs 
vim.o.shiftwidth=2
vim.o.tabstop=2
vim.o.expandtab=true
vim.o.list=true
vim.o.listchars='tab:>-'

-- Configure livedown
vim.g.livedown_port = 1227

-- Configure extra space for comments
vim.g.NERDSpaceDelims=1

--Configure fzf colors
vim.g.fzf_colors = {
  fg =     {'fg', 'Normal'},
  bg =     {'bg', 'Normal'},
  hl =     {'fg', 'Comment'},
  ['fg+']= {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
  ['bg+']= {'bg', 'CursorLine', 'CursorColumn'},
  ['hl+']= {'fg', 'Statement'},
  info=    {'fg', 'PreProc'},
  border=  {'fg', 'Ignore'},
  prompt=  {'fg', 'Conditional'},
  pointer= {'fg', 'Exception'},
  marker=  {'fg', 'Keyword'},
  spinner= {'fg', 'Label'},
  header=  {'fg', 'Comment'}
}
vim.api.nvim_create_user_command('Rg', "call fzf#vim#grep('rg --column --sort path --line-number --no-heading --color=always --colors \"path:fg:215,135,95\" --colors \"line:fg:128,128,128\" --smart-case '.shellescape(<q-args>), 1, { 'options': '--color hl:223,hl+:222 --delimiter : --nth 4..' }, 0)", {bang=true, nargs="*"})

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
