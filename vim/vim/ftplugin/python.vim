try
  py3 import sys
catch E319
  py import sys
endtry
let python_highlight_all=1
let g:jedi#force_py_version = 3
let g:jedi#popup_select_first = 0
setlocal expandtab ts=4 sw=4 ai
setlocal omnifunc=python3complete#Complete
set textwidth=79
setlocal colorcolumn=+1
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
map <buffer><silent><F5> :!python3 %:p<CR><CR>

syntax on
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
" let g:SuperTabContextDiscoverDiscovery =
  " \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
setlocal rnu
" setlocal foldmethod=indent
" IPython
