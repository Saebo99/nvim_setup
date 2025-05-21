-- lua/plugins/cmp.lua
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',                  -- snippet engine
      'saadparwaiz1/cmp_luasnip',          -- cmp <-> snippet bridge
      'hrsh7th/cmp-nvim-lsp',              -- LSP source
      'hrsh7th/cmp-buffer',                -- words in current buffer
      'hrsh7th/cmp-path',                  -- file system paths
      'hrsh7th/cmp-emoji',                 -- :smile: → 😄
    },
    config = function()
      --------------------------------------------------------
      -- 1.  Snippet engine setup (LuaSnip)
      --------------------------------------------------------
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load() -- friendly-snippets
  
      --------------------------------------------------------
      -- 2. nvim-cmp configuration
      --------------------------------------------------------
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          -- Enter ↵: confirm selection
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          -- Tab ↹: next item *or* expand snippet / jump
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          -- Shift-Tab: previous item or jump backward in snippet
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip'   },
          { name = 'path'      },
          { name = 'buffer'    },
          { name = 'emoji'     },
        }),
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            local icons = {
              Text = '󰉿 ', Method = '󰆧 ', Function = '󰡱 ', Constructor = ' ',
              Field = '󰜢 ', Variable = '󰀫 ', Class = '󰠱 ', Interface = ' ',
              Module = ' ', Property = '󰜢 ', Unit = '󰑭 ', Value = '󰎠 ',
              Enum = ' ', Keyword = '󰌋 ', Snippet = ' ', Color = '󰏘 ',
              File = '󰈙 ', Reference = '󰈇 ', Folder = '󰉋 ', EnumMember = ' ',
              Constant = '󰏿 ', Struct = '󰙅 ', Event = ' ', Operator = '󰆕 ',
              TypeParameter = ''
            }
            vim_item.kind = icons[vim_item.kind] or ''
            vim_item.menu = (
              {
                nvim_lsp = '[LSP]', luasnip = '[Snip]', buffer = '[Buf]',
                path = '[Path]', emoji = '[Emoji]'
              })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  }