function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end


return {
  { "rose-pine/neovim",      name = "rose-pine" },
  { "morhetz/gruvbox",       name = "gruvbox" },
  { "catppuccin/nvim",       name = "catppuccin" },
  { "folke/tokyonight.nvim", name = "tokyonight" },

  config = function()
    require("rose-pine").setup({ variant = "moon" })
    vim.cmd("colorscheme rose-pine")

  end,
}

