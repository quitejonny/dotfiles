" pandoc , markdown
setlocal spell
setlocal spelllang=de
setlocal formatoptions-=t
setlocal linebreak
setlocal breakindent
setlocal breakindentopt=shift:2

nmap <silent> <Leader>ll :call markdown#compile()<CR><CR>
nmap <Leader>ln :! cd %:p:h && pandoc %:p --template=modac -V documentclass=modac -o %:p:h/%:t:r.pdf<CR>
nmap <Leader>lp :call Markdown_Run_revealjs()<CR><CR>
nmap <Leader>l[ :call ToggleMarkdownReload()<CR><CR>
nmap <Leader>lt :! cd %:p:h && pandoc %:p ~/.pandoc/metadata.yml -s -o /tmp/%:t:r.tex<CR>
nmap <silent> <Leader>lv :! xdg-open %:p:h/%:t:r.pdf<CR><CR>

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

fun! markdown#compile()
  silent !clear
  exec "!cd %:p:h && pandoc --number-sections --filter pandoc-citeproc %:p -o %:p:h/%:t:r.pdf &"
endfun

fun! markdown#Citation(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && (line[start-2:start-1] != '[@')
      let start -= 1
    endwhile
    return start
  else
    let bibLine = getline(search('^bibliography:.*\.bib$'))
    let literaturFile = substitute(bibLine, '^bibliography:\s\+\(.\+\.bib\)$', '\1', '')
    let matches=systemlist('grep "^@\w\+{\w\+,$" ' . literaturFile . ' | sed "s/@\w\+{\(\w\+\),/\1/"')
    let res = []
    for m in matches
      if m =~ '^' . a:base
        call add(res, m)
      endif
    endfor
    return res
  endif
endfun

setlocal completefunc=markdown#Citation
