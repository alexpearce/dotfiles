-- Language servers
-------------------

-- Setup omnifunc and key bindings when attaching to an LSP server
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap = true, silent = true}
  require('which-key').register(
    {
      g = {
        name = 'Goto',
        D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
        -- d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Definition' },
        d = { '<cmd>TroubleToggle lsp_definitions<cr>', 'Definition' },
        i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation' },
        K = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Help' },
        s = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature' },
        r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
        -- u = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Usages' },
        u = { '<cmd>TroubleToggle lsp_references<cr>', 'Usages' },
        a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
        [']'] = { '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', 'Next Diagnoistic' },
        ['['] = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', 'Previous Diagnoistic' },
        -- l = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Location List' },
        l = { '<cmd>TroubleToggle lsp_document_diagnostics<cr>', 'Location List' },
      }
    },
    {
      prefix = '<leader>'
    }
  )
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)

  -- Show a lightbulb in the gutter when a code action is available
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

  require('lsp-status').on_attach(client)
end

local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable C, Python, and Rust language servers
local servers = {'clangd', 'pyright', 'rust_analyzer', 'null-ls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

vim.o.completeopt = 'menuone,noinsert'

-- Compe setup
-- Copy-pasted from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local replace_termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return replace_termcodes('<C-n>')
  elseif check_back_space() then
    return replace_termcodes('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return replace_termcodes('<C-p>')
  else
    return replace_termcodes('<S-Tab>')
  end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
