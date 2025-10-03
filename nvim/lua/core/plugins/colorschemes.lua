return {

    {
        'folke/tokyonight.nvim',
        name = 'tokyonight',
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function()
            require("core.plugins.themes.tokyonight")
            vim.cmd("colorscheme tokyonight-night")
        end,
    },
}
