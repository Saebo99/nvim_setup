-- lua/plugins/lsp.lua
return {
    ------------------------------------------------------------
    -- 1) Mason: install/manage LSP servers, DAPs, linters, etc.
    ------------------------------------------------------------
    {
      'williamboman/mason.nvim',
      build  = ':MasonUpdate',
      config = function()
        require('mason').setup()
      end,
    },
  
    ---------------------------------------------------------------------
    -- 2) mason-lspconfig: only install servers (no config here)
    ---------------------------------------------------------------------
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = { 'williamboman/mason.nvim' },
      -- no config = function() … end
    },
  
    ---------------------------------------------------------------------
    -- 3) nvim-lspconfig: configure all servers in one place
    ---------------------------------------------------------------------
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        { 'hrsh7th/nvim-cmp',      event = 'InsertEnter' },
        { 'hrsh7th/cmp-nvim-lsp' },
      },
      config = function()
        local mlsp      = require('mason-lspconfig')
        local lspconfig = require('lspconfig')
        local configs   = require('lspconfig.configs')
  
        -- a) Servers you *want* installed; Mason will handle these
        local install = {
          'bashls',
          'pyright',
          'lua_ls',
          'html',
          'cssls',
          'jsonls',
          'clangd',
          'rust_analyzer',
          'eslint',
        }
  
        mlsp.setup {
          ensure_installed      = install,
          automatic_installation = true,
        }
  
        -- b) Side‐by‐side on_attach and capabilities
        local on_attach = function(_, bufnr)
          local map = function(keys, fn, desc)
            vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = 'LSP: '..desc })
          end
          map('gd',  vim.lsp.buf.definition,        'Definition')
          map('gD',  vim.lsp.buf.declaration,       'Declaration')
          map('gr',  require('telescope.builtin').lsp_references, 'References')
          map('K',   vim.lsp.buf.hover,             'Hover docs')
          map('<F2>',vim.lsp.buf.rename,            'Rename symbol')
          map('[d',  vim.diagnostic.goto_prev,      'Prev diagnostic')
          map(']d',  vim.diagnostic.goto_next,      'Next diagnostic')
          map('<leader>ca', vim.lsp.buf.code_action,'Code action')
        end
  
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        pcall(function()
          capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        end)
  
        -- c) Only configure servers that actually exist in lspconfig.configs
        for _, name in ipairs(install) do
          if configs[name] then
            local opts = {
              on_attach    = on_attach,
              capabilities = capabilities,
            }
            if name == 'lua_ls' then
              opts.settings = {
                Lua = {
                  workspace  = { checkThirdParty = false },
                  telemetry  = { enable = false },
                },
              }
            end
            lspconfig[name].setup(opts)
          end
        end
  
        -- d) Diagnostic signs/icons
        local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
        for type, icon in pairs(signs) do
          vim.fn.sign_define('DiagnosticSign'..type, { text = icon, texthl = 'DiagnosticSign'..type })
        end
        vim.diagnostic.config { virtual_text = false, severity_sort = true }
      end,
    },
  }