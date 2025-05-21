-- lua/plugins/format.lua
return {
    {
      'nvimtools/none-ls.nvim',
      dependencies = {
        'williamboman/mason.nvim',
        'jay-babu/mason-null-ls.nvim',
      },
      config = function()
        -- 1. Create a named augroup for formatting autocmds
        local fmt_group = vim.api.nvim_create_augroup('NoneLsFmt', { clear = true })
  
        -- 2. mason-null-ls: auto-install the CLIs
        require('mason-null-ls').setup {
          ensure_installed = {
            'prettierd',  -- JS/TS formatter
            'stylua',     -- Lua formatter
            'black',      -- Python formatter
          },
          automatic_installation = true,
        }
  
        -- 3. null-ls setup
        local nls  = require('null-ls')
        local fmt  = nls.builtins.formatting
        local diag = nls.builtins.diagnostics
  
        nls.setup {
          sources = {
            fmt.prettierd.with({ extra_filetypes = { 'svelte', 'astro' } }),
            fmt.stylua,
            fmt.black,
          },
          on_attach = function(client, bufnr)
            if client.supports_method('textDocument/formatting') then
              -- clear prior autocmds in this group+buffer
              vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = bufnr })
              -- format on save
              vim.api.nvim_create_autocmd('BufWritePre', {
                group  = fmt_group,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
                end,
              })
            end
          end,
        }
      end,
    },
  }