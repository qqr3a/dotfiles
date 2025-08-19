return {
    "gorbit99/codewindow.nvim",
    config = function()
        local codewindow = require("codewindow")
        codewindow.setup({
            minimap_width = 12,
            use_treesitter = true,
            use_lsp = true,
            use_git = true,
            auto_enable = false,
        })
        vim.keymap.set("n", "<leader>cw", codewindow.toggle_minimap, { desc = "Toggle CodeWindow Minimap" })
    end,
}
