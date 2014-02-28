"---------------------------------------------------------------------
" Name: Quirky
" Author: Nicholas Quirk (nmquirk@gmail.com)
" Last Change: 2013-08-28
" Description: Vim color file
"---------------------------------------------------------------------

set background=light
highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="quirky"

" Global
hi Normal       guifg=#000000     guibg=#EEEEFF
hi NonText      guifg=#C4BA00

" Search
hi Search       guifg=black
hi IncSearch    guifg=black

" Syntax Highlighting Groups
hi Comment      guifg=#22AA1F                   gui=italic
hi Constant     guifg=#FF66D6                   gui=bold
hi Error        guifg=#FFFFFF   guibg=#D02503
hi Function     guifg=#C4008C                   gui=bold
hi Identifier   guifg=black
hi Label        guifg=black
hi Number       guifg=#A03508                   gui=bold
hi Operator     guifg=#1243FF                   gui=bold
hi PreProc      guifg=#751875                   gui=bold
hi Special      guifg=#FF66D6                   gui=bold
hi Statement    guifg=#D02503                   gui=bold
hi String       guifg=#574296                   gui=italic
hi Type         guifg=#227716
hi Keyword      guifg=black

" Interface Elements
hi Cursor                       guibg=#751875
hi CursorLine                   guibg=#D6D6FF
hi Folded       guifg=black
hi LineNr       guifg=#A03508   guibg=#D6D6FF     gui=italic
hi MatchParen   guifg=#FF66D6   guibg=#66FF8F
hi Pmenu        guifg=black
hi SignColumn   guifg=black
hi StatusLine   guifg=#000000
hi StatusLineNC guifg=#000000
hi VertSplit    guifg=black

" Specials
hi Todo         guifg=black
hi Title        guifg=black

" Lisp/Clojure Colors
"hi link LispList Function
"hi link LispSymbol Function

" Vimwiki
hi link VimwikiHeaderChar   Statement
hi link VimwikiHeader1      Statement
hi link VimwikiHeader2      Statement
hi link VimwikiHeader3      Statement
hi link VimwikiHeader4      Statement

" HTML
hi htmlTag            guifg=#5a72bb gui=NONE
hi htmlSpecialTagName guifg=#5a72bb gui=NONE
hi htmlTagName        guifg=#5a72bb gui=NONE
hi htmlEndTag         guifg=#5a72bb gui=NONE
