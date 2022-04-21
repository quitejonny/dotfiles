" setlocal foldmethod=indent
" no automatic linebreak when textwidth is reached
setlocal formatoptions-=t
setlocal textwidth=100
setlocal colorcolumn=+1
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

function! WikiIndent()
	let a:line = getline(v:lnum)
	let a:prevNum = prevnonblank(v:lnum - 1)
	let a:prev = getline(a:prevNum)
	if a:prev =~ '\(\$*%\|\$\(dollar\)*percnt\)\w\+{.*}\1'
		return indent(a:prevNum)
	elseif a:prev =~ '\(\$*%\|\$\(dollar\)*percnt\)\w\+{'
		return indent(a:prevNum) + &tabstop
	elseif a:line =~ '}\(\$*%\|\$\(dollar\)*percnt\)'
		return indent(a:prevNum) - &tabstop
	else
		return indent(a:prevNum)
	endif
endfunction

function! EscapeExpression(isEscaped)
	if a:isEscaped
		s/\ze%/\$/ge
		s/\$\zs\ze\(dollar\)*perce\?nt/dollar/ge
		s/\ze\"/\\/ge
	else
		s/[$]\@<!\$perce\?nt/%/ge
		s/\$\zs\(dollar\)\ze\(dollar\)*perce\?nt//ge
		s/[$]\@<!\$\ze\(\$\)*%//ge
		s/\\\ze\"//ge
	endif
endfunction

function! WikiExpand(isExpanded)
	if a:isExpanded
		s/\v\$\zs(\$*)\%/\=substitute(submatch(1), '\$', "dollar", "g") . "percnt"/ge
	else
		s/\v\$\zs((dollar)*)perce?nt/\=substitute(submatch(1), 'dollar', '\$', "g") .'%'/ge
	endif
endfunction

setlocal indentexpr=WikiIndent()

call IMAP('if`', "IF{\<CR>\"<+cond+>\"\<CR>then=\"<+then+>\"<++> else=\"<+else+>\"\<CR>\<c-d>}<++>", 'wiki')
call IMAP('search`', "SEARCH{\<CR>\"<++>\"\<CR>type=\"<++>\"\<CR>limit=\"<++>\"\<CR>nonoise=\"<++>\"\<CR>format=\"<++>\"\<CR>\<c-d>}<++>", 'wiki')

nnoremap <F5> ms:%call WikiExpand(1)<CR>`s
nnoremap <s-F5> ms:%call WikiExpand(0)<CR>`s
vnoremap <silent> <F5> :call WikiExpand(1)<CR>
vnoremap <silent> <s-F5> :call WikiExpand(0)<CR>
vnoremap <F6> :call EscapeExpression(1)<CR>
vnoremap <s-F6> :call EscapeExpression(0)<CR>
