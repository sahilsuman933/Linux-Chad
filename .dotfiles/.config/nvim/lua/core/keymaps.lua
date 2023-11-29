vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Save, Copy and Paste Keymapping
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-c>', '"+y', {noremap = true})
vim.api.nvim_set_keymap('x', '<C-c>', '"+y', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', {noremap = true})
vim.api.nvim_set_keymap('x', '<C-v>', '"+p', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', {noremap = true})

-- Tab
vim.api.nvim_set_keymap('n', '<C-n>', ':tabnew<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprevious<CR>', {noremap = true, silent = true})


vim.api.nvim_set_keymap('n', '<CS-B>', [[<cmd>lua print('ctrl+shift+b')<cr>]], {noremap = true})






