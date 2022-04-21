nmap <silent> <Leader>ll :call lilypond#compile()<CR><CR>
nmap <silent> <Leader>lv :! xdg-open %:p:h/%:t:r.pdf<CR><CR>

fun! lilypond#compile()
  silent !clear
  exec "!cd %:p:h && lilypond % &"
endfun
