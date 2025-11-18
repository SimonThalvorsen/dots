-----------------------------------------------------------
-- BASIC OPTIONS
-----------------------------------------------------------
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = ""
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"

-----------------------------------------------------------
-- LAZY
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- PLUGINS
-----------------------------------------------------------
require("lazy").setup({

  -----------------------------------------------------------
  -- UI + THEMES
  -----------------------------------------------------------
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup({ transparent = true })
      vim.cmd("colorscheme vague")
    end
  },

  -----------------------------------------------------------
  -- FILETREE
  -----------------------------------------------------------
  {
    "stevearc/oil.nvim",
    opts = {
      float = { border = "rounded", max_width = 0.7, max_height = 0.6 },
      lsp_file_methods = { enabled = true },
    }
  },

  -----------------------------------------------------------
  -- TELESCOPE (find files, live grep, etc.)
  -----------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      "LinArcX/telescope-env.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
        },
      })
      telescope.load_extension("ui-select")
      telescope.load_extension("env")
    end,
  },

  -----------------------------------------------------------
  -- TREESITTER
  -----------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = { highlight = { enable = true } },
  },

  -----------------------------------------------------------
  -- LSP + AUTOCOMPLETE + SNIPPETS
  -----------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      -------------------------------------------------------
      -- MASON
      -------------------------------------------------------
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "tinymist", 
          "clangd", "ruff", "glsl_analyzer"
          
        }
      })

      -------------------------------------------------------
      -- CMP AUTOCOMPLETE
      -------------------------------------------------------
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },
      })

      -------------------------------------------------------
      -- LSP SETUP
      -------------------------------------------------------
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      -- Format keymap
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
    end
  },

  -----------------------------------------------------------
  -- LAZYGIT
  -----------------------------------------------------------
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  -----------------------------------------------------------
  -- MARKS
  -----------------------------------------------------------
  { "chentoast/marks.nvim", config = true },

  -----------------------------------------------------------
  -- TYPST PREVIEW
  -----------------------------------------------------------
  { "chomosuke/typst-preview.nvim", ft = "typst" },
})

-----------------------------------------------------------
-- KEYMAPS (ASTRONVIM-LIKE)
-----------------------------------------------------------
local map = vim.keymap.set

-- Telescope
local tb = require("telescope.builtin")
map("n", "<leader>f", tb.find_files)
map("n", "<leader>g", tb.live_grep)
map("n", "<leader>b", tb.buffers)
map("n", "<leader>h", tb.help_tags)

-- Oil
map("n", "<leader>e", "<cmd>Oil<CR>")

-- Lazygit
map("n", "<leader>lg", "<cmd>LazyGit<CR>")

-- Quality of life
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-----------------------------------------------------------
-- DONE
-----------------------------------------------------------

