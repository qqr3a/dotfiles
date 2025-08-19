return {
    "xiyaowong/transparent.nvim",
    config = function()
        require("transparent").setup({
            enable = true,
            extra_groups = {
                "NormalFloat",
                "FloatBorder",
                "TelescopeNormal",
                "TelescopeBorder",
                "TelescopePromptNormal",
                "TelescopePromptBorder",
                "TelescopeResultsNormal",
                "TelescopeResultsBorder",
                "TelescopePreviewNormal",
                "TelescopePreviewBorder",
            },
            exclude_groups = {},
        })
        require("transparent").clear_prefix("Telescope")
    end,
}
