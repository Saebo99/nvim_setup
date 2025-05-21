-- lua/core/keymaps.lua
vim.g.mapleader = " "

local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Quick exit from insert
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- Splits
map('n', 'sv', ':vsplit<CR>',  vim.tbl_extend('force', opts, { desc = 'Vertical split' }))
map('n', 'sh', ':split<CR>',   vim.tbl_extend('force', opts, { desc = 'Horizontal split' }))

-- Window focus
map('n', '<leader>h', '<C-w>h', vim.tbl_extend('force', opts, { desc = 'Focus left'  }))
map('n', '<leader>j', '<C-w>j', vim.tbl_extend('force', opts, { desc = 'Focus down'  }))
map('n', '<leader>k', '<C-w>k', vim.tbl_extend('force', opts, { desc = 'Focus up'    }))
map('n', '<leader>l', '<C-w>l', vim.tbl_extend('force', opts, { desc = 'Focus right' }))