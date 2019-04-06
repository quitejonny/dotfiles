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
nmap <Leader>ln :! cd %:p:h && pandoc %:p ~/.pandoc/metadata.yml -o /tmp/%:t:r.pdf<CR>
nmap <Leader>lt :! cd %:p:h && pandoc %:p ~/.pandoc/metadata.yml -s -o /tmp/%:t:r.tex<CR>
nmap <silent> <Leader>lv :! xdg-open /tmp/%:t:r.pdf<CR><CR>
