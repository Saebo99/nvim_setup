-- lua/plugins/treesitter.lua
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',          -- auto-compile grammars on update
    event = { 'BufReadPost', 'BufNewFile' }, -- lazy-load when a file opens
    dependencies = {
      'windwp/nvim-ts-autotag',   -- auto close / rename HTML & JSX tags
    },
    opts = {
      ensure_installed = { 'lua', 'vim', 'bash', 'python', 'javascript', 'html', 'css', 'json', 'markdown' },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent     = { enable = true },
      autotag    = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  }