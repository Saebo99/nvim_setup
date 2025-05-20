-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
    {
        'folke/tokyonight.nvim', -- Color scheme
        lazy = false,            -- Load immediately
        priority = 1000,         -- High priority for loading
        config = function()
            vim.cmd [[colorscheme tokyonight-night]]
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        opts = {
            theme = "tokyonight",
        },
    },
    -- >>> Telescope & file-browser <<<
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",    -- async helpers
            "nvim-tree/nvim-web-devicons" -- icons everywhere
        },
        cmd = "Telescope",              -- lazy-load
        keys = {
            {
                "sf", -- search files
                function()
                    require("telescope").extensions.file_browser.file_browser({
                        path          = "%:p:h", -- start in current file’s dir
                        select_buffer = true,
                    })
                end,
                mode = "n",
                desc = "File browser (cwd)"
            },
        },
        opts = function()
            local actions    = require("telescope.actions")
            local fb_actions = require("telescope").extensions.file_browser.actions
            return {
                defaults = {
                    prompt_prefix    = "   ",
                    selection_caret  = " ",
                    sorting_strategy = "descending",
                    layout_strategy  = "flex",
                    layout_config    = { prompt_position = "bottom", width = 0.90, height = 0.85 },
                    winblend         = 5, -- slight transparency
                    border           = true,
                    path_display     = { "smart" },
                    mappings         = {
                        i = { ["<Esc>"] = actions.close },
                        n = { ["<Esc>"] = actions.close },
                    },
                },
                extensions = {
                    file_browser = {
                        grouped      = true,
                        hijack_netrw = true,
                        initial_mode = "normal",
                        previewer    = false,
                        mappings     = {
                            ["n"] = {
                                ["N"] = fb_actions.create, -- Shift+N → new file / dir
                            },
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("file_browser")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim", -- extension plugin
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim", -- the extension itself
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
})

vim.g.mapleader = " " -- Set leader key to space

-- 2. Basic UI tweaks
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = false -- Relative line numbers
vim.opt.termguicolors = true   -- Enable 24-bit RGB colors
vim.opt.cursorline = true      -- Highlight the current line

-- 4. Keybindings
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window splits
map("n", "sv", ":vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Vertical split" }))
map("n", "sh", ":split<CR>", vim.tbl_extend("force", opts, { desc = "Horizontal split" }))

-- Window navigation (review from Part 2)
map("n", "<leader>h", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Focus left window" }))
map("n", "<leader>j", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Focus lower window" }))
map("n", "<leader>k", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Focus upper window" }))
map("n", "<leader>l", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Focus right window" }))
