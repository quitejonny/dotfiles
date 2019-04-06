setlocal ts=4 sw=4 ai expandtab
setlocal textwidth=100
setlocal colorcolumn=+1
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
syntax on
setlocal rnu

function! Qt_RunQmake()
	let l:origDir = fnameescape(getcwd())
	let l:buildDir = Qt_GetMainFolder() . "/build"
	let l:projFile = globpath(Qt_GetMainFolder(), "*.pro")
	if ! isdirectory(l:buildDir)
		call mkdir(l:buildDir)
	endif
	if l:projFile != ""
		exe 'cd ' . l:buildDir
		exe '!qmake ' . l:projFile
		make
		exe 'cd ' . l:origDir
	endif
endfunction

function! Qt_RunExe()
	let l:projFile = globpath(Qt_GetMainFolder(), "*.pro")
	let l:projContent = join(readfile(l:projFile), "\n")
	let l:target = matchstr(l:projContent, '\s*TARGET\s*=\s*\zs\w\+')
	let l:targetFile = Qt_GetMainFolder() . "/build/" . l:target
	exe '! ' . l:targetFile
endfunction

function! Qt_GetMainFolder()
	let l:modifier = "%:p:h"
	let l:folder = expand(l:modifier)
	while l:folder != '/'
		if findfile(".ycm_extra_conf.py") != ''
			return l:folder
		endif
		let l:modifier .= ':h'
		let l:folder = expand(l:modifier)
	endwhile
	return expand("%:p:h")
endfunction

function! Qt_RunDesigner()
	let l:uiFiles = split(globpath(Qt_GetMainFolder(), "**/*.ui"), '\n')
	exe '! qtcreator ' . join(l:uiFiles, ' ') . ' &'
endfunction

nnoremap <silent> <F5> :call Qt_RunQmake()<CR>
nnoremap <silent> <F6> :call Qt_RunExe()<CR>
nnoremap <silent> <F7> :call Qt_RunDesigner()<CR><CR>
