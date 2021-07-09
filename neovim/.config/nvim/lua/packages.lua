-- Plugin management
--------------------

-- Install packer if not already present
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

-- Run PackerCompile whenever this file is written
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost packages.lua PackerCompile
  augroup end
]], false)

require('packer').startup(function(use)
  -- Package management
  use 'wbthomason/packer.nvim'

  -- Editing
  use 'ggandor/lightspeed.nvim'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'wincent/loupe'

  -- UI
  use {
    'projekt0n/github-nvim-theme',
    after = 'lualine.nvim',
    config = function()
      require('github-theme').setup({
        themeStyle = 'light',
        keywordStyle = 'NONE',
      })
    end
  }
  use {
    'hoob3rt/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'github'
        }
      })
      -- Mode symbols not exposed as options, so modify internals
      local mode_map = {
        n  = '∙',
        i  = '|',
        v  = '→',
        V  = '↔',
        [''] = '↕',
        c = '$'
      }
      for k, v in pairs(mode_map) do
        require('lualine.utils.mode').map[k] = v
      end
    end
  }
  -- Git signs in the gutter
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Find anything
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    after = 'which-key.nvim',
    config = function()
      require('which-key').register(
        {
          f = {
            name = 'find',
            f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Find File' },
            h = { "<cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>", 'Find Hidden File' },
            b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", 'Find Buffer' },
            g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Find Text' },
          }
        },
        {
          prefix = '<leader>'
        }
      )
    end
  }

  -- Discover mappings
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end
  }

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'beancount',
          'cmake',
          'cpp',
          'dockerfile',
          'elixir',
          'fish',
          'html',
          'json',
          'latex',
          'lua',
          'python',
          'regex',
          'rust',
          'toml',
          'yaml',
        },
        indent = {enable = true},
        highlight = {enable = true},
      })
    end
  }
  use {'ivan-krukov/vim-snakemake', ft = 'snakemake'}

  -- Language servers
  use {
    'neovim/nvim-lspconfig',
    after = {'which-key.nvim', 'nvim-compe', 'nvim-lightbulb'},
    config = function()
      require('language_servers')
    end
  }
  -- LSP UI
  use 'kosayoda/nvim-lightbulb'
  -- Completion
  use 'hrsh7th/nvim-compe'
end)
