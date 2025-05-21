-- lua/plugins/git.lua
return {
    ------------------------------------------------------------------
    -- 1. Gitsigns — inline hunks & blame
    ------------------------------------------------------------------
    {
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      event = { 'BufReadPre', 'BufNewFile' },
      opts = {
        signs = {
          add          = { text = '▎' },
          change       = { text = '▎' },
          delete       = { text = '▶' },
          topdelete    = { text = '‾' },
          changedelete = { text = '▎' },
        },
        numhl      = true,    -- highlight line number instead of sign column
        current_line_blame = true,
        current_line_blame_opts = { delay = 500, virt_text_pos = 'eol' },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          -- Hunk navigation
          map('n', ']g', function() gs.nav_hunk('next') end, 'Next hunk')
          map('n', '[g', function() gs.nav_hunk('prev') end, 'Prev hunk')
          -- Actions
          map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
          map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset hunk')
          map('n', '<leader>hp', gs.preview_hunk_popup, 'Preview hunk')
        end,
      },
    },
  
    ------------------------------------------------------------------
    -- 2. vim-fugitive — full Git inside Neovim
    ------------------------------------------------------------------
    {
      'tpope/vim-fugitive',
      cmd = { 'Git', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite' },
      keys = {
        { '<leader>gs', ':Git status<CR>', desc = 'Git status' },
        { '<leader>gc', ':Git commit<CR>', desc = 'Git commit' },
        { '<leader>gd', ':Gdiffsplit<CR>', desc = 'Diff against index' },
      },
    },
  }