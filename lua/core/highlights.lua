-- lua/core/highlights.lua
local set = vim.api.nvim_set_hl

-- Dim non-current windows
set(0, 'NormalNC', { bg = 'NONE', fg = '#5c6370' })

-- Make Telescope prompt border blue
set(0, 'TelescopeBorder', { fg = '#7aa2f7', bg = 'NONE' })

-- Underline TODO comments (works after we add todo-comments plugin later)
set(0, 'Todo', { fg = '#f7768e', standout = true, underline = true })