local opts = { noremap = true, silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local settings = require("core.settings")
local o = vim.opt

vim.g.have_nerd_font = true

vim.wo.cursorline = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--Set highlight on search
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

--Make line numbers default
vim.wo.number = settings.number
vim.wo.relativenumber = settings.relative_number

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.grepprg = "rg --vimgrep --smart-case --"

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

--Set scroll offset
vim.o.scrolloff = settings.scrolloff

-- make copying better
-- keymap("n", "Y", "yg$", opts)
keymap("n", "<leader>y", "\"+y", opts)
-- copy whole big word into global buffer
keymap("n", "<leader>j", "\"+yiW", opts)
keymap("v", "<leader>y", "\"+y", opts)
vim.api.nvim_set_keymap('n', '<Leader>Y', '"+yg$', { noremap = true })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- format selected JSON
keymap("v", "<leader>jq", ":!jq<cr>", opts)

-- accept copilot suggestions
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

local qf_func = {}

qf_func["toggle"] = "<cmd>lua require('core.utils.functions').toggle_qf()<CR>"
keymap("n", "<leader>qq", qf_func["toggle"], { desc = "Toggle quickfix" })
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
