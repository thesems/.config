return {
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "go", "rust", "javascript", "typescript", "tsx", "json" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search Text" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        preview = {
          treesitter = false,
        },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>t", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      window = {
        width = 30,
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
      { "<leader>bd", "<cmd>BufferLinePickClose<cr>", desc = "Pick buffer to close" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },

  {
    "nvim-mini/mini.bufremove",
    version = false,
    keys = {
      {
        "<leader>bc",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Close current buffer",
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle floating terminal" },
    },
    opts = {
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },

  { "williamboman/mason.nvim", cmd = "Mason", opts = {} },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Show keymaps",
      },
    },
    config = function()
      local which_key = require("which-key")
      which_key.setup({
        plugins = {
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
          },
        },
        triggers = {
          { "<leader>", mode = "n" },
          { "f", mode = { "n", "x", "o" } },
          { "F", mode = { "n", "x", "o" } },
          { "t", mode = { "n", "x", "o" } },
          { "T", mode = { "n", "x", "o" } },
          { "c", mode = { "n", "x", "o" } },
          { "d", mode = { "n", "x", "o" } },
          { "y", mode = { "n", "x", "o" } },
        },
      })
      which_key.add({
        { "<leader>f", group = "Files" },
        { "<leader>b", group = "Buffers" },
        { "<leader>g", group = "Git" },
        { "<leader>j", group = "Jump" },
        { "<leader>c", group = "Text" },
        { "<leader>n", group = "Navigate" },
        { "<leader>r", group = "References" },
        { "<leader>u", group = "Tests" },
        { "<leader>x", group = "Trouble" },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=false<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>rr", "<cmd>Trouble lsp_references toggle focus=false<cr>", desc = "References (Trouble)" },
      { "<leader>rd", "<cmd>Trouble lsp_definitions toggle focus=false<cr>", desc = "Definitions (Trouble)" },
      { "<leader>ri", "<cmd>Trouble lsp_implementations toggle focus=false<cr>", desc = "Implementations (Trouble)" },
      { "<leader>rt", "<cmd>Trouble lsp_type_definitions toggle focus=false<cr>", desc = "Type Definitions (Trouble)" },
    },
  },

  {
    "nvim-neotest/neotest",
    cmd = { "Neotest" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        status = {
          enabled = true,
          signs = true,
          virtual_text = true,
        },
        adapters = {
          require("neotest-vitest"),
        },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "none",
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "select_and_accept", "fallback" },
          ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
          ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = {
          documentation = {
            auto_show = false,
          },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        fuzzy = {
          implementation = "prefer_rust_with_warning",
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "isort", "black" },
          go = { "goimports", "gofmt" },
          rust = { "rustfmt" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "ruff" },
        go = { "golangcilint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("LintOnSave", { clear = true }),
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local ft = vim.bo[bufnr].filetype
          local linters = lint.linters_by_ft[ft] or {}
          local available_linters = {}

          for _, linter in ipairs(linters) do
            if vim.fn.executable(linter) == 1 then
              available_linters[#available_linters + 1] = linter
            end
          end

          if #available_linters > 0 then
            lint.try_lint(available_linters)
          end
        end,
      })
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
