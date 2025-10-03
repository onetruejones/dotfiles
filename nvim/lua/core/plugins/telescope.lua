return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    cmd = "Telescope",
    dependencies = {
        "jvgrootveld/telescope-zoxide",
        "crispgm/telescope-heading.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    keys = {
        { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands"},
        { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Strings" },
        { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
        { "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = '[S]earch Recent Files ("." for repeat)' },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
        { "<leader>rr", "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>ss", "<cmd>Telescope grep_string<cr>", desc = "Text under cursor" },
        { "<leader>s;", "<cmd>Telescope command_history<cr>", desc = "Command history" },
        { "<leader>sa", "<cmd>Telescope search_history<cr>", desc = "Search history" },
        -- git
        -- files
        { "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true grouped=true<cr>", desc = "Filebrowser" },
        { "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
        { "<leader>ff", "<cmd>" .. require("core.utils.functions").project_files() .. "<cr>", desc = "Open file" },
        { "<leader>gg", "<cmd>Telescope git_status<cr>", desc = "Status" },
        -- Other
        { "<leader>cc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
        { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Bufferlist" },
        { "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
        { "<C-p>", "<cmd>lua require'telescope.builtin'.git_files {}<cr>", desc = "Git files" },
    },
    config = function()
        local settings = require("core.settings")
        local telescope = require("telescope")
        local telescopeConfig = require("telescope.config")
        local actions = require("telescope.actions")
        local action_layout = require("telescope.actions.layout")
        local fb_actions = require("telescope").extensions.file_browser.actions
        local devicons = require("nvim-web-devicons").setup({ default = true })
        --local icons = require("core.utils.icons")

        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
        if settings.telescope_grep_hidden then
            table.insert(vimgrep_arguments, "--hidden")
        end
        -- trim the indentation at the beginning of presented line
        table.insert(vimgrep_arguments, "--trim")

        telescope.setup({
            extensions = {
                --fzf = fzf_opts,
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = false,
                    hidden = false,
                    mappings = {
                        i = {
                            ["<c-n>"] = fb_actions.create,
                            ["<c-r>"] = fb_actions.rename,
                            -- ["<c-h>"] = actions.which_key,
                            ["<c-h>"] = fb_actions.toggle_hidden,
                            ["<c-x>"] = fb_actions.remove,
                            ["<c-p>"] = fb_actions.move,
                            ["<c-y>"] = fb_actions.copy,
                            ["<c-a>"] = fb_actions.select_all,
                        },
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = false,
                },
                buffers = {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                },
                live_grep = {
                    --sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
                    only_sort_text = true, -- grep for content and not file name/path
                    mappings = {
                        i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
                    },
                },
            },
            defaults = {
                file_ignore_patterns = settings.telescope_file_ignore_patterns,
                vimgrep_arguments = vimgrep_arguments,
                mappings = {
                    i = {
                        -- Close on first esc instead of going to normal mode
                        -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                        ["<C-r>"] = actions.smart_send_to_qflist,
                        ["<C-l>"] = actions.send_to_qflist,
                        --["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        --["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<cr>"] = actions.select_default,
                        ["<c-v>"] = actions.select_vertical,
                        ["<c-s>"] = actions.select_horizontal,
                        ["<c-t>"] = actions.select_tab,
                        ["<c-p>"] = action_layout.toggle_preview,
                        ["<c-o>"] = action_layout.toggle_mirror,
                        ["<c-h>"] = actions.which_key,
                        ["<c-x>"] = actions.delete_buffer,
                    },
                },
                --prompt_prefix = table.concat({ icons.arrows.ChevronRight, " " }),
                --selection_caret = icons.arrows.CurvedArrowRight,
                entry_prefix = "  ",
                --multi_icon = icons.arrows.Diamond,
                initial_mode = "insert",
                scroll_strategy = "cycle",
                selection_strategy = "reset",
                sorting_strategy = "descending",
                layout_strategy = "vertical",
                layout_config = {
                    width = 0.95,
                    height = 0.85,
                    -- preview_cutoff = 120,
                    prompt_position = "top",
                    horizontal = {
                        preview_width = function(_, cols, _)
                            if cols > 200 then
                                return math.floor(cols * 0.4)
                            else
                                return math.floor(cols * 0.6)
                            end
                        end,
                    },
                    vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
                    flex = { horizontal = { preview_width = 0.9 } },
                },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                use_less = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            },
        })

        --telescope.load_extension("projects")
        telescope.load_extension("zoxide")
        telescope.load_extension("heading")
        telescope.load_extension("ui-select")
        --telescope.load_extension("make")
        if settings.enable_noice then
            telescope.load_extension("noice")
        end
        --telescope.load_extension("fzf")
    end,
}
