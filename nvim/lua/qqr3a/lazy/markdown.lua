return {
  "OXY2DEV/markview.nvim",
  lazy = false,        -- **must** load before nvim-treesitter
  dependencies = {
    "nvim-treesitter/nvim-treesitter",  -- so you can install parsers
  },
  config = function()
    require("markview").setup({
      mappings = {
        open = { "<CR>", "gx" },
      },
    })

    -- optional: a convenient keymap to toggle preview
    vim.keymap.set("n", "<leader>m", function()
      vim.cmd("Markview toggle")
    end, { desc = "Toggle markview preview" })
  end,
}

