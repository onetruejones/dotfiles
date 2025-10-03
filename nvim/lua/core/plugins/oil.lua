return {

  -- "stevearc/oil.nvim",
  -- keys = {
  --   { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
  -- },
  -- opts = {
  --   default_file_explorer = true,
  --   delete_to_trash = true,
  --   skip_confirm_for_simple_edits = true,
  -- },
  'stevearc/oil.nvim',
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('oil').setup()
  end,
}
