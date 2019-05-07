" pandoc , markdown
setlocal spell
setlocal spelllang=de
setlocal tabstop=4
setlocal shiftwidth=4
setlocal textwidth=100
setlocal autoindent
setlocal expandtab
setlocal formatoptions-=t

setlocal linebreak
setlocal breakindent
setlocal breakindentopt=shift:2

let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

call IMAP('`=>', '⇒<++>', 'markdown')
call IMAP('`->', '→<++>', 'markdown')

nmap <silent> <Leader>ll :! cd %:p:h && pandoc %:p -o /tmp/%:t:r.pdf&<CR><CR>
nmap <Leader>ln :! cd %:p:h && pandoc %:p -V documentclass=modac -o /tmp/%:t:r.pdf<CR>
nmap <Leader>lp :call Markdown_Run_revealjs()<CR><CR>
nmap <Leader>l[ :call ToggleMarkdownReload()<CR><CR>
nmap <Leader>lt :! cd %:p:h && pandoc %:p ~/.pandoc/metadata.yml -s -o /tmp/%:t:r.tex<CR>
nmap <silent> <Leader>lv :! xdg-open /tmp/%:t:r.pdf<CR><CR>

fun! ToggleMarkdownReload()
  if !exists("g:toggleMarkdownReload_isEnabled")
    let g:toggleMarkdownReload_isEnabled=0
  endif

  if !g:toggleMarkdownReload_isEnabled
    let g:toggleMarkdownReload_isEnabled=1
    :autocmd BufWritePost * silent! call Markdown_Run_revealjs()
  else
    let g:toggleMarkdownReload_isEnabled=0
    :autocmd! BufWritePost *
  endif
  echo "toggleMarkdownReload_isEnabled: " . g:toggleMarkdownReload_isEnabled
endfun

fun! Markdown_Run_revealjs()
  :! cd %:p:h && pandoc %:p -t revealjs -s -o %:t:r.html --template=modac
endfun
