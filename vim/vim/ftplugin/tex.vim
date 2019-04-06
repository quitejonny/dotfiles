" LaTeX filetype plugin
" Language:     LaTeX (ft=tex)
" Maintainer:   Johannes Roos <johannes.roos@rwth-aachen.de>
" Version:	1.0
" Last Change:	Sun 15 Mar 2015
"  URL:		http://www.vim.org/script.php?script_id=411

" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin")
  finish
endif

" Folgende Zeile wurde nachtraeglich von Johannes Roos eingefuehrt
set iskeyword+=:
let g:Tex_inputenc_options = '\<utf8\>'
let g:Tex_Flavor='latex'
let g:Tex_UseJabref = 0
" This line is for latex-suite
let g:Tex_SmartQuoteOpen = '"`'
let g:Tex_SmartQuoteClose = "\"'"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_BibtexFlavor = 'biber'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
" let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'

" Start with plain TeX.  This will also define b:did_ftplugin .
" source $VIMRUNTIME/ftplugin/plaintex.vim

" Avoid problems if running in 'compatible' mode.
" let s:save_cpo = &cpo
" set cpo&vim

" let b:undo_ftplugin .= "| setl inex<"

" Allow "[d" to be used to find a macro definition:
" Recognize plain TeX \def as well as LaTeX \newcommand and \renewcommand .
" I may as well add the AMS-LaTeX DeclareMathOperator as well.
" let &l:define .= '\|\\\(re\)\=new\(boolean\|command\|counter\|environment\|font'
"     \ . '\|if\|length\|savebox\|theorem\(style\)\=\)\s*\*\=\s*{\='
"     \ . '\|DeclareMathOperator\s*{\=\s*'

" Tell Vim how to recognize LaTeX \include{foo} and plain \input bar :
" let &l:include .= '\|\\include{'
" On some file systems, "{" and "}" are inluded in 'isfname'.  In case the
" TeX file has \include{fname} (LaTeX only), strip everything except "fname".
" let &l:includeexpr = "substitute(v:fname, '^.\\{-}{\\|}.*', '', 'g')"

" The following lines enable the macros/matchit.vim plugin for
" extended matching with the % key.
" ftplugin/plaintex.vim already defines b:match_skip and b:match_ignorecase
" and matches \(, \), \[, \], \{, and \} .
" if exists("loaded_matchit")
"   let b:match_words .= ',\\begin\s*\({\a\+\*\=}\):\\end\s*\1'
" endif " exists("loaded_matchit")

" let &cpo = s:save_cpo

" vim:sts=2:sw=2:
" sets tabwith, shiftwidth, autocomplete
setlocal expandtab ts=2 sw=2 ai
setlocal linebreak
setlocal breakindent
setlocal breakindentopt=shift:2
setlocal spell spelllang=de_de
setlocal spellfile+=~/.vim/spell/tex.utf-8.add
setlocal formatoptions-=t

imap <buffer> "a ä
imap <buffer> "A Ä
imap <buffer> "u ü
imap <buffer> "U Ü
imap <buffer> "o ö
imap <buffer> "O Ö
imap <buffer> "s ß

" adds sum command for completion
let g:Tex_Com_sum = "\\sum_{<++>}^{<++>}<++>"
let g:Tex_Com_binom = "\\binom{<++>}{<++>}<++>"
call IMAP('`o', '\cdot<++>', 'tex')
