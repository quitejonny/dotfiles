"============================================================================
"
" TWiki syntax file
"
" Language:    TWiki
" Last Change: Wed Nov 22 16:14:41 UTC 2006
" Maintainer:  Rainer Thierfelder <rainer{AT}rainers-welt{DOT}de>
" Additions:   Eric Haarbauer <ehaar{DOT}com{AT}grithix{DOT}dyndns{DOT}org>
"              Antonio Terceiro <terceiro{AT}users{DOT}sourceforge{DOT}net>
" License:     GPL (http://www.gnu.org/licenses/gpl.txt)
"    Copyright (C) 2004-2006  Rainer Thierfelder
"
"    This program is free software; you can redistribute it and/or modify
"    it under the terms of the GNU General Public License as published by
"    the Free Software Foundation; either version 2 of the License, or
"    (at your option) any later version.
"
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"
"    You should have received a copy of the GNU General Public License
"    along with this program; if not, write to the Free Software
"    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
"
"============================================================================
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'twiki'
endif

runtime! syntax/html.vim

"============================================================================
" Group Definitions:    {{{1
"============================================================================

syntax match twikiSeparator    "^---\+"
syntax match twikiBulletedList "^\(   \)\+\*\ze "
syntax match twikiOrderedList  "^\(   \)\+1\ze "

syntax match twikiVariableParam contained "[a-z0-9]*="
syntax match twikiVariableNoPar "\([^!]\|^\)%\w\+%"
syntax match twikiTag      "<\w\+>"

function! s:AddTwikiVariable(num)
    let firstdollar = a:num == 1 ? '' : '\$'
    let num_count = a:num == 1 ? 0 : a:num - 2
    let expand = a:num == 1 ? "" : '\|\(dollar\)\{' . num_count . '}perce\?nt'

    let macro = firstdollar . '\(\$\{' . num_count . '}%' . expand . '\)'
    let start = '[!$]\@<!' . macro . '\(\w\+:\)\?\w\+{'
    let end =  '}' . macro
    exec 'syntax region twikiVariable start="' . start . '" end="' . end . '"'
        \ . ' contains=twikiVariableParam,twikiVarVal,twikiSimpleVar,twikiVariable'
        \ . ' containedin=htmlTag'
    " set twikiSimpleVar
    exec 'syntax match twikiSimpleVar "[!$]\@<!' . macro . '\(\w\+:\)\?\w\+' . macro . '"'
        \ . ' containedin=htmlTag'
    " set twikiVarVal
    let n = a:num - 1
    exec 'syntax region twikiVarVal start="\\\{' . n . '}\""'
        \ .' skip="\\\{' . a:num . ',}\"" end="\\\{' . n . '}\""'
        \ .' contains=twikiSimpleVar,twikiVariable'
endfunction

call s:AddTwikiVariable(1)
call s:AddTwikiVariable(2)
call s:AddTwikiVariable(3)
call s:AddTwikiVariable(4)
call s:AddTwikiVariable(5)

syntax match twikiDelimiter "|"

syntax region twikiComment  start="<!--" end="-->"
syntax region twikiComment start="%{" end="}%"
syntax region twikiVerbatim matchgroup=twikiTag
    \ start="<verbatim>" end="</verbatim>"
syntax region twikiPre matchgroup=twikiTag contains=twikiVariable,twikiSimpleVar
    \ start="<pre>" end="</pre>"

syntax region twikiHeading matchgroup=twikiHeadingMarker contains=twikiVariable,twikiVariableNoPar oneline
    \ start="^---+\+" end="$"

"let s:wikiWord = '\(\w\+\.\)\?\u[a-z0-9]\+\(\u[a-z0-9]\+\)\+'
let s:wikiWord = '\u\+[a-z0-9]\+\(\u\+[a-z0-9]\+\)\+'

execute 'syntax match twikiAnchor +^#'.s:wikiWord.'\ze\(\>\|_\)+'
execute 'syntax match twikiWord +\(\s\|^\)\zs\(\u\l\+\.\)\='.s:wikiWord.'\(#'.s:wikiWord.'\)\=\ze\(\>\|_\)+'
" Regex guide:                   ^pre        ^web name       ^wikiword  ^anchor               ^ post

" Links: {{{2
syntax region twikiLink matchgroup=twikiLinkMarker
    \ start="\( \|^\)\zs\[\[" end="\]\]\ze\([,. ?):-]\|$\)"
    \ contains=twikiForcedLink,twikiLinkRef keepend

execute 'syntax match twikiForcedLink +[ A-Za-z0-9]\+\(#'.s:wikiWord.'\)\=+ contained'

syntax match twikiLinkRef    ".\{-}\ze\]\["
    \ contained contains=twikiLinkMarker nextgroup=twikiLinkLabel
syntax match twikiLinkLabel  ".\{-}\ze\]\]"   contained contains=twikiLinkMarker
syntax match twikiLinkMarker "\]\["           contained

" Emphasis:  {{{2
function! s:TwikiCreateEmphasis(token, name)
    execute 'syntax region twiki'.a:name.
           \' oneline start=+\(^\|[ ]\)\zs'.a:token.
           \'+ end=+'.a:token.'\ze\([,. ?):-]\|$\)+'
endfunction

" call s:TwikiCreateEmphasis('=',  'Fixed')
" call s:TwikiCreateEmphasis('==', 'BoldFixed')
" call s:TwikiCreateEmphasis('\*', 'Bold')
" call s:TwikiCreateEmphasis('_',  'Italic')
" call s:TwikiCreateEmphasis('__', 'BoldItalic')
"
syntax sync fromstart

"============================================================================
" Group Linking:    {{{1
"============================================================================

hi link twikiHeading       Title
hi link twikiHeadingMarker Operator
hi link twikiVariable      PreProc
hi link twikiSimpleVar     PreProc
hi link twikiVariableNoPar PreProc
hi link twikiVariableParam Type
hi link twikiVarVal        String
hi link twikiTag           PreProc
hi link twikiComment       Comment
hi link twikiWord          Tag
hi link twikiAnchor        PreProc
hi link twikiVerbatim      Constant
hi link twikiPre           Constant
hi link twikiBulletedList  Operator
hi link twikiOrderedList   Operator

hi link twikiDelimiter     Operator

" Links
hi twikiLinkMarker term=bold cterm=bold gui=bold
hi link   twikiForcedLink Tag
hi link   twikiLinkRef    Tag
hi link   twikiLinkLabel  Identifier

" Emphasis
hi twikiFixed      term=underline cterm=underline gui=underline
hi twikiBoldFixed  term=bold,underline cterm=bold,underline gui=bold,underline
hi twikiItalic     term=italic cterm=italic gui=italic
hi twikiBoldItalic term=bold,italic cterm=bold,italic gui=bold,italic
hi twikiBold       term=bold cterm=bold gui=bold

"============================================================================
" Clean Up:    {{{1
"============================================================================

if main_syntax == 'twiki'
  unlet main_syntax
endif

let b:current_syntax = "twiki"

" vim:fdm=marker
