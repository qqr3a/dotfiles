return {
    {
        "nvim-telescope/telescope.nvim",

        tag = "0.1.5",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "andrew-george/telescope-themes",
        },
        lazy = false,

        config = function()
            require("telescope").setup({})
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            require("telescope").load_extension("themes")
            vim.keymap.set(
                "n",
                "<leader>th",
                ":Telescope themes<CR>",
                { noremap = true, silent = true, desc = "Theme Switcher" }
            )
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        lazy = false,
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
