return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                lazy = true,
            },
        },
        opts = {
            sections = {
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        newfile_status = true,
                        path = 3,
                    },
                },
            },
        },
        config = function(_, opts)
            require("lualine").setup(opts)
        end
    }
}
