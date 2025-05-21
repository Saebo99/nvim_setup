-- lua/plugins/telescope.lua
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-file-browser.nvim',
    -- new ↓
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'ahmedkhalf/project.nvim',
    'cljoly/telescope-repo.nvim',
  },
  cmd = 'Telescope',
  keys = {
    { 'sf', function()
        require('telescope').extensions.file_browser.file_browser({ path = '%:p:h', select_buffer = true })
      end, mode = 'n', desc = 'File browser (cwd)' },
    -- new keymaps
    { '<leader>ff', function() require('telescope.builtin').find_files({ hidden = true }) end,  desc = 'Find files' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end,                   desc = 'Live grep' },
    { '<leader>fb', function() require('telescope.builtin').buffers() end,                     desc = 'Buffers' },
    { '<leader>fp', function() require('telescope').extensions.projects.projects() end,        desc = 'Projects' },
    { '<leader>fr', function() require('telescope').extensions.repo.list() end,                desc = 'Git repos' },
  },
  opts = function()
    local actions    = require('telescope.actions')
    local fb_actions = require('telescope').extensions.file_browser.actions
    return {
      defaults = {
        prompt_prefix = '   ',
        selection_caret = ' ',
        sorting_strategy = 'descending',
        layout_strategy = 'flex',
        layout_config = { prompt_position = 'bottom', width = 0.9, height = 0.85 },
        winblend = 5,
        mappings = { i = { ['<Esc>'] = actions.close }, n = { ['<Esc>'] = actions.close } },
      },
      extensions = {
        fzf = { case_mode = 'smart_case' },
        file_browser = {
          grouped = true, hijack_netrw = true, initial_mode = 'normal', previewer = false,
          mappings = { ['n'] = { ['N'] = fb_actions.create } },
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension('fzf')
    telescope.load_extension('file_browser')
    telescope.load_extension('projects')
    telescope.load_extension('repo')
    require('project_nvim').setup({ '.git', 'pyproject.toml', 'package.json' })  -- minimal project.nvim config
  end,
}