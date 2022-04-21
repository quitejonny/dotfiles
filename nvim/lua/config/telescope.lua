require('telescope').setup()
require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope git_files<CR>', {});
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<CR>', {});
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {});
