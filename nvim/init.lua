require("plugins")

local opt = vim.opt

opt.relativenumber = true
opt.undofile = true
opt.writebackup = false
opt.modeline = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.autoindent = true

vim.api.nvim_exec(
[[
fun! ToggleUmlauts()
  if !exists("g:toggleUmlauts_isEnabled")
    let g:toggleUmlauts_isEnabled=0
  endif

  if !g:toggleUmlauts_isEnabled
    let g:toggleUmlauts_isEnabled=1
    imap <buffer> "a ä
    imap <buffer> "A Ä
    imap <buffer> "u ü
    imap <buffer> "U Ü
    imap <buffer> "o ö
    imap <buffer> "O Ö
    imap <buffer> "s ß
  else
    let g:toggleUmlauts_isEnabled=0
    iunmap <buffer> "a
    iunmap <buffer> "A
    iunmap <buffer> "u
    iunmap <buffer> "U
    iunmap <buffer> "o
    iunmap <buffer> "O
    iunmap <buffer> "s
  endif
endfun

inoremap <F2> <esc>:call ToggleUmlauts()<cr>a
]],
true)

opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.api.nvim_set_keymap('n', '<leader>a', ':silent lgrep \"\\b<cword>\\b\"<CR><CR>:lopen<CR>', {});
