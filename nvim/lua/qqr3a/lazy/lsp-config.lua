return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.jedi_language_server.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			--lspconfig.ltex.setup({
			--	capabilities = capabilities,
			--	filetypes = { "text", "markdown", "tex" },
			--	settings = {
			--		ltex = {
			--			language = { "en-GB" },
			--			diagnosticSeverity = "information",
			--			additionalRules = { motherTongue = "en" },
			--		},
			--	},
			--	disabledRules = {
			--		["en-GB"] = {
			--			"OXFORD_SPELLING_ISE_VERB", 
			--			"MORFOLOGIK_RULE_EN_GB", -- Commonly too picky with tech words
			--		},
			--	},
			--})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})

			lspconfig.bashls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
