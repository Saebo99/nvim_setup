-- lua/plugins/treesitter.lua
return {
  'nvim-treesitter/nvim-treesitter',
  build        = ':TSUpdate',
  event        = { 'BufReadPost', 'BufNewFile' },
  dependencies = 'windwp/nvim-ts-autotag',

  opts         = {
    ensure_installed = {
      'lua', 'vim', 'bash', 'python', 'javascript', 'html', 'css',
      'json', 'jsonc', 'markdown', 'gitignore', 'yaml', 'toml', 'rust', 'cpp', 'c',
    },

    highlight        = {
      enable = true,
      additional_vim_regex_highlighting = false,

      -- Skip UI / popup / no-file buffers to avoid “Invalid value … b”
      disable = function(_, buf)
        local bt = vim.bo[buf].buftype
        if bt ~= '' and bt ~= 'acwrite' then -- nofile, prompt, popup, help, etc.
          return true                    -- → don’t attach Tree-sitter
        end
        return false
      end,
    },

    indent           = { enable = true },
    autotag          = { enable = true },
  },

  config       = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
