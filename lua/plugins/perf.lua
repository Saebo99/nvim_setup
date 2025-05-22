-- lua/plugins/perf.lua
return {
    --------------------------------------------------------------------
    -- 1.  Lazy-Nvim profiling UI  ─  :Lazy profile
    --------------------------------------------------------------------
    {
      'folke/lazy.nvim',
      -- already loaded as the manager; we only extend its opts ↓
      init = function()
        -- Record plugin load times; view with :Lazy profile
        require('lazy.core.config').options.defaults = {
          lazy = true,          -- everything lazy-loads unless you opt-out
        }
      end,
    },
  
    --------------------------------------------------------------------
    -- 2.  StartupTime command  ─  :StartupTime
    --------------------------------------------------------------------
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',     -- loads only when you run the command
    },
  
    --------------------------------------------------------------------
    -- 3.  Conditional loader helper (example)
    --------------------------------------------------------------------
    {
      'lukas-reineke/indent-blankline.nvim',
      event = { 'BufReadPre' },           -- load only when a file is opened
      ft    = { 'lua', 'python', 'json' },-- and only for these filetypes
      opts  = { char = '│', show_trailing_blankline_indent = false },
    },
  }