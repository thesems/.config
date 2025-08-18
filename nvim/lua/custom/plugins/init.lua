return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {
      contrast = 'soft', -- Or "hard" / "medium"
      transparent_mode = false,
    },
    config = function(_, opts)
      require('gruvbox').setup(opts)
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    { 'akinsho/toggleterm.nvim', version = '*', opts = { direction = 'float', open_mapping = [[<c-\>]] } },
  },
  {
    -- :BlameToggle
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            runner = 'pytest',
            args = { '--log-level', 'DEBUG' },
          },
          require 'neotest-plenary',
          require 'neotest-vim-test' {
            ignore_file_types = { 'python', 'vim', 'lua' },
          },
        },
      }
    end,
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {},
  },
}
