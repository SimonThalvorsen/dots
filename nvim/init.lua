-----------------------------------------------------------
-- BASIC OPTIONS
-----------------------------------------------------------
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.wrap = false
-- vim.o.colorcolumn = 72
vim.o.textwidth = 72
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"

-----------------------------------------------------------
-- LAZY (PLUGIN MANAGER)
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- PLUGINS
-----------------------------------------------------------
require("lazy").setup({

	-----------------------------------------------------------
	-- UI + THEME
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
	-- TELESCOPE
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
		end
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
			-- Mason
			-------------------------------------------------------
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "clangd" },
			})

			-------------------------------------------------------
			-- CMP (Autocomplete)
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
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				}),
			})

			-------------------------------------------------------
			-- LSP SETUP
			-------------------------------------------------------
			-- local lspconfig = require("lspconfig")
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			--
			-- for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
			--   lspconfig[server].setup({
			--     capabilities = capabilities,
			--   })
			-- end

			-------------------------------------------------------
			-- LSP KEYMAPS
			-------------------------------------------------------
			local map = vim.keymap.set
			map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
			map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Quick fix" })
			map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Goto definition" })
			map("n", "<leader>lu", vim.lsp.buf.references, { desc = "Goto usages" })
			map("n", "<leader>lq", vim.lsp.buf.hover, { desc = "Hover error" })
			map("n", "<leader>lS", "<cmd>vsplit | :Telescope lsp_document_symbols<CR>", { desc = "LSP symbols outline" })
		end
	},


	-------------------------------------------------------
	-- WHICH-KEY
	-------------------------------------------------------
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
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
	{ "chentoast/marks.nvim",         config = true },

	-----------------------------------------------------------
	-- TYPST PREVIEW
	-----------------------------------------------------------
	{ "chomosuke/typst-preview.nvim", ft = "typst" },
})

-----------------------------------------------------------
-- KEYMAPS
-----------------------------------------------------------
local map = vim.keymap.set

-- Telescope
local tb = require("telescope.builtin")
map("n", "<leader>ff", tb.find_files, {desc = "find files"})
map("n", "<leader>fw", tb.live_grep, {desc = "find words"})
map("n", "<leader>fh", tb.help_tags, {desc = "find help"})

-- Oil
map("n", "<leader>e", "<cmd>Oil<CR>")

-- Lazygit
map("n", "<leader>gg", "<cmd>LazyGit<CR>", {desc = "Lazygit"})

-- QOL
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

-- BUFFER 
map("n", "<leader>bb", tb.buffers, {desc = "find buffers"})
map("n", "<leader>b\\", "<cmd>split<CR>", {desc = "New horisontal buffer"})
map("n", "<leader>b|", "<cmd>vsplit<CR>", {desc = "New vertical buffer"})
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
