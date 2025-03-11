-- Ensure lazy.nvim is added to runtime path
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Load lazy.nvim and configure plugins
require("lazy").setup({

  -- File Explorer (NvimTree)
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
          number = true,
          relativenumber = true,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = { git = true },
          },
        },
      })
    end,
  },

  -- Tab bar (Bufferline)
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          show_buffer_close_icons = false,
          separator_style = "thin",
        },
      })
    end,
  },

  -- Theme (Nordic)
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()
    end,
  },
	
  -- Dashboard (Alpha.nvim)
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                             ",
        "",
        "",
        "",
        "██    ██  ██████  ██ ██████  ",
        "██    ██ ██    ██ ██ ██   ██ ",
        "██    ██ ██    ██ ██ ██   ██ ",
        " ██  ██  ██    ██ ██ ██   ██ ",
        "  ████    ██████  ██ ██████  ",
        "                             ",
        "        quantumvoid          ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "📄  New File", ":ene <BAR> startinsert<CR>"),
        dashboard.button("q", "🚪  Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.config)
      vim.cmd([[ highlight Type guifg=#cacccb0 ]]) -- Nordic Cyan
    end,
  },

  -- Status Line (Lualine)
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "nordic" },
      })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
     require("lspconfig").ts_ls.setup({})
      require("lspconfig").html.setup({})
      require("lspconfig").cssls.setup({})
    end,
  },

  -- Auto-completion (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Smooth Scrolling (Neoscroll)
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup()
    end,
  },

})

-- Hide the default startup message
vim.opt.shortmess:append("I")

-- Enable absolute and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = "set norelativenumber" })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set relativenumber" })

-- Keybindings

-- Toggle NvimTree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Tab Navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true }) -- Next tab
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true }) -- Previous tab
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true }) -- Close tab

-- Copy & Paste (Ctrl+C, Ctrl+V)
vim.api.nvim_set_keymap("n", "<C-c>", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-v>", '<C-r>+', { noremap = true, silent = true })

-- Save with Ctrl+S
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- Open new tab with Ctrl+T
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { noremap = true, silent = true })

-- Close current tab with Ctrl+W
vim.keymap.set("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true }) -- Use `:bd<CR>` if you want buffer close instead

-- Select all with Ctrl+A
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true })

