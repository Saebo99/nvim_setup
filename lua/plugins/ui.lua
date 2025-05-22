-- lua/plugins/ui.lua
return {
    ------------------------------------------------------------------
    -- 1.  noice.nvim + dependencies
    ------------------------------------------------------------------
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            lsp = {
                progress = { enabled = true },
                signature = { enabled = true },
            },
            presets = { bottom_search = true, command_palette = true },
            -- **disable TS decorations in Noice UI**
            views = {
                cmdline_popup = { winhighlight = { Normal = 'Normal', FloatBorder = 'FloatBorder' } },
                popupmenu     = { enabled = false }, -- turn off TS for popupmenu
            },
        },
    },

    ------------------------------------------------------------------
    -- 2. which-key — discover keymaps
    ------------------------------------------------------------------
    -- lua/plugins/ui.lua
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',

        -- 1) Neovim must wait for key sequences
        init = function()
            vim.o.timeout    = true
            vim.o.timeoutlen = 300
        end,

        -- 2) New opts syntax—disable the unused icons plugin
        opts = {
            plugins = {
                marks     = true,
                registers = true,
                spelling  = false,
                icons     = false, -- disable mini.icons integration
            },
            win = {
                border   = 'rounded',
                position = 'bottom',
            },
            layout = { align = 'left' },
        },

        -- 3) Register mappings using the modern spec
        config = function(_, opts)
            local wk = require('which-key')
            wk.setup(opts)

            -- a) Leader-prefix groups
            wk.register({
                g = { name = '+git' },
                f = { name = '+find' },
            }, { prefix = '<leader>', mode = 'n' })

            -- b) Stand-alone keys
            wk.register({
                ['[t']         = { 'Prev TODO' },
                [']t']         = { 'Next TODO' },
                ['<leader>st'] = { 'Search TODOs' },
            }, { mode = 'n' })
        end,
    },

    ------------------------------------------------------------------
    -- 3. todo-comments — highlight & list TODO/FIXME
    ------------------------------------------------------------------
    {
        'folke/todo-comments.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = 'nvim-lua/plenary.nvim',
        opts = { signs = true },
        keys = {
            { ']t',         function() require('todo-comments').jump_next() end, desc = 'Next TODO' },
            { '[t',         function() require('todo-comments').jump_prev() end, desc = 'Prev TODO' },
            { '<leader>st', ':TodoTelescope<CR>',                                desc = 'Search TODOs' },
        },
    },

    ------------------------------------------------------------------
    -- 4. illuminate — word under cursor
    ------------------------------------------------------------------
    {
        'RRethy/vim-illuminate',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('illuminate').configure({ delay = 200 })
        end,
    },
}
