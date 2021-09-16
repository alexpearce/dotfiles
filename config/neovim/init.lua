--[[
Inspired by:

- https://github.com/mjlbach/defaults.nvim
- https://blog.inkdrop.info/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887
- https://crispgm.com/page/neovim-is-overpowering.html
- https://github.com/nanotee/nvim-lua-guide
--]]

require('packages')

-- General configuration
------------------------

-- Enable persistent undo
vim.o.undofile = true

-- Enable the mouse in the terminal
vim.o.mouse = 'a'

-- Use a venv just for Neovim (see `:help python-virtualenv`)
vim.g.python3_host_prog = vim.env.HOME .. '/.venvs/neovim/bin/python'

-- Disable unused remote providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

-- UI
-----

-- Don't use the native mode display, lualine does this for us
vim.o.showmode = false

-- Have some context around the current line always on screen
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5

-- show trailing whitespace as -, tabs as >-
vim.o.listchars = 'tab:>-,trail:-'
vim.o.list = true

-- Live substitution
vim.o.inccommand = 'split'

-- Mappings
-----------

-- Set the leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear search highlighting with <space>,
vim.api.nvim_set_keymap('n', '<leader>,', '<Plug>(LoupeClearHighlight)', {})

-- Paste from the system clipboard
-- https://tilvim.com/better-pasting-from-the-clipboard/
-- map <Leader>p :set paste<cr>o<esc>'+]p:set nopaste<cr>

-- Scroll up and down visible lines, not buffer lines, with j and k
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})

-- Navigate tabs with shift-{h,l}
vim.api.nvim_set_keymap('n', '<S-l>', 'gt', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-h>', 'gT', {noremap = true})

-- Navigate splits with control-{h,j,k,l}
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})

-- Create horizontal (<space>-) and vertical (<space>|) splits
vim.api.nvim_set_keymap('n', '<Leader>-', ':split<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>|', ':vsplit<cr>', {noremap = true})

-- Quickly save, quit, or save-and-quit
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>x', ':x<cr>', {})

-- Toggle line numbers (absolute current, relative neighbouring) with <space>l
ToggleRelativeLineNumbers = function()
  vim.o.number = not vim.o.number
  vim.o.relativenumber = not vim.o.relativenumber
end
vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>lua ToggleRelativeLineNumbers()<cr>', {noremap = true})

-- Toggle indentation guides
vim.api.nvim_set_keymap('n', '<Leader>i', '<cmd>lua require("indent_blankline.commands").toggle()<cr>', {noremap = true})

-- Coding style
---------------

-- Tabs as two spaces
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Makefiles require actual tabs
vim.cmd('au FileType make setlocal noexpandtab')

-- Don't create backup files when editing crontabs
vim.cmd('au filetype crontab setlocal nobackup nowritebackup')

-- Enable marker folds for Beancount files
vim.cmd('au FileType beancount setlocal foldmethod=marker foldlevel=0 foldlevelstart=0')

-- Enable spell-checking for text files
vim.cmd('au FileType tex,plaintex,markdown,rst setlocal spelllang=en_gb spell')
