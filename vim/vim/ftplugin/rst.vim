" create nmap
function! CreatePdf()
  silent !rst2latex % > %:r.tex
  silent !pdflatex %:r.tex %:r.pdf
  silent !rm %:r.aux %:r.log %:r.tex %:r.out
  sleep 800m
  redraw!
endfunction

function! OpenPdf()
  silent !evince %:r.pdf &
  sleep 200m
  redraw!
endfunction
nmap <silent> <F4> :call CreatePdf()<CR>
nmap <silent> <F5> :call OpenPdf()<CR>
