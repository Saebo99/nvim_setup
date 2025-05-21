-- lua/plugins/init.lua

-- 1. lazy.nvim bootstrap (unchanged)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- 2. require the plugin spec list from sibling files
require('lazy').setup({
    require('plugins.telescope'), -- our Telescope chunk
    require('plugins.treesitter'), -- our Treesitter chunk
    require('plugins.lsp'),       -- our LSP chunk
    require('plugins.cmp'),       -- our completion chunk
    require('plugins.format'), -- our formatting chunk
    require('plugins.git'),   -- our Git chunk
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        opts = {
            style = 'night',    -- other options: 'storm', 'moon', 'day'
            transparent = true, -- let terminal show through
            styles = {
                sidebars = 'transparent',
                floats   = 'transparent',
            },
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
            vim.cmd.colorscheme 'tokyonight'
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme                = 'tokyonight',
                icons_enabled        = true,
                section_separators   = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        },
    },
})
