-- lua/core/options.lua
local opt          = vim.opt

---------------------------------------------------------------------
-- Existing settings
---------------------------------------------------------------------
opt.number         = true
opt.relativenumber = false -- change to true if you prefer hybrid line numbers
opt.termguicolors  = true
opt.cursorline     = true
opt.clipboard:append('unnamedplus') -- system clipboard integration

---------------------------------------------------------------------
-- 1.  Indentation / tabs
---------------------------------------------------------------------
opt.expandtab            = true -- convert <Tab> presses to spaces
opt.shiftwidth           = 2 -- size of an <Indent>  (>> / <<)  (= 2 spaces)
opt.tabstop              = 2 -- visual width of <Tab> characters
opt.softtabstop          = 2 -- <BS> behaves like backspacing 2 spaces
opt.smartindent          = true -- auto-indent new lines based on syntax

-- If you ever need true tabs (e.g. for Makefiles) use :set noexpandtab

---------------------------------------------------------------------
-- 2.  UI niceties
---------------------------------------------------------------------
opt.signcolumn           = 'yes' -- never shift text when gitsigns/diagnostics appear
opt.mouse                = 'a' -- enable mouse support in all modes
opt.scrolloff            = 4 -- keep 4 screen lines above/below cursor
opt.sidescrolloff        = 8 -- same for left/right
opt.colorcolumn          = '120' -- guide at 120 characters (adjust to taste)
opt.breakindent          = true -- wrapped lines continue indented
opt.splitright           = true -- :vsplit puts new window to the right
opt.splitbelow           = true -- :split puts new window below

---------------------------------------------------------------------
-- 3.  Searching
---------------------------------------------------------------------
opt.ignorecase           = true -- case-insensitive search…
opt.smartcase            = true -- …unless pattern contains capitals
opt.inccommand           = 'split' -- live preview for :substitute
opt.incsearch            = true -- jump while typing
opt.hlsearch             = false -- no highlight after search (toggle with :noh)

---------------------------------------------------------------------
-- 4.  Performance
---------------------------------------------------------------------
opt.updatetime           = 300 -- CursorHold event & LSP diagnostics responsiveness
opt.timeoutlen           = 300 -- mapped sequence wait time (needed for which-key)

---------------------------------------------------------------------
-- 5.  Undo history
---------------------------------------------------------------------
opt.undofile             = true -- persistent undo
opt.undodir              = vim.fn.stdpath('cache') .. '/undo'

---------------------------------------------------------------------
-- 6.  Disable built-in plugins you never use (optional)
---------------------------------------------------------------------
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.json',
    callback = function() vim.bo.filetype = 'jsonc' end,
})
