" ============================================================================
"                       Global Settings
" ============================================================================

set encoding=utf8
set paste
set noexpandtab
set textwidth=0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set backspace=indent,eol,start
set incsearch
set ignorecase
set ruler
set wildmenu
set commentstring=\ #\ %s
set foldlevel=0
set clipboard+=unnamed
set nobackup
set nowritebackup
set nowrap
set list
set number
set ai
set ts=4
set sts=4
set et
set sw=4
set textwidth=79
set textwidth=80
set noswapfile
set colorcolumn=80
set hidden

let mapleader = ","

" Highlight current line only in insert mode.
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

" Highlight cursor in terminal.
highlight CursorLine ctermbg=8 cterm=NONE

syntax enable

if has('gui_running')
    set background=dark
else
    set background=light
endif

colorscheme quirky

" ============================================================================
"                       Global Styles
" ============================================================================

" Invisibles font color.
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" ============================================================================
"                       OS Settings
" ============================================================================

if has("win32") || has("win64")

    let windows=1
    let vimfiles=$HOME . "/vimfiles"
    let sep=";"
    set listchars=tab:»\ ,eol:¬
    set guifont=Consolas:h11

    " VimWiki
    let g:vimwiki_list = [{'path': '~\Dropbox\Wiki\vimwiki\', 'html_header': '~/vimwiki_html/header.tpl'}]

else

    let windows=0
    let vimfiles=$HOME . "/.vim"
    let sep=":"
    set listchars=tab:▸\ ,eol:¬
    set guifont=Monaco:h16 " set guifont=Droid\ Sans\ Mono\ 11

    " VimWiki
    let g:vimwiki_list = [{'path': '~/Dropbox/Wiki/vimwiki/'}]

endif

" ============================================================================
"                       Plugin Settings
" ============================================================================

" Load plugins from .vim/bundles using .vim/autoload/pathogen.vim
" call pathogen#runtime_append_all_bundles()
call pathogen#infect()

syntax on
filetype plugin indent on

" Load built-in plugins.
runtime macros/matchit.vim

" VimWiki
let g:vimwiki_table_auto_fmt = 0

" ----------------------------------------------------------------------------
"                       Clojure
" ----------------------------------------------------------------------------

let classpath = join(
   \[".",
   \ "src", "src/main/clojure", "src/main/resources",
   \ "test", "src/test/clojure", "src/test/resources",
   \ "classes", "target/classes",
   \ "lib/*", "lib/dev/*",
   \ "bin",
   \ vimfiles."/lib/*"
   \],
   \ sep)

" Settings for VimClojure.
let slime_target = "screen"
let slimv_swank_cmd = '! xterm -e sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp &'
let slimv_swank_clojure = '! xterm -e lein swank &'
let vimclojureRoot = vimfiles."/bundle/vimclojure-2.3.1"
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = vimclojureRoot."/lib/nailgun/ng"
if windows
   " In stupid windows, no forward slashes, and tack on .exe.
    let vimclojure#NailgunClient = substitute(vimclojure#NailgunClient, "/", "\\", "g") . ".exe"
endif


" ----------------------------------------------------------------------------
"                       JavaScript
" ----------------------------------------------------------------------------

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" ============================================================================
"                       Key Mappings
" ============================================================================

" ----------------------------------------------------------------------------
"                       General
" ----------------------------------------------------------------------------

" Shortcut to rapidly toogle 'set list'.
nmap <leader>l :set list!<CR>

" Use bracket keys to indent blocks.
nmap <C-[> <<
nmap <C-]> >>
vmap <C-[> <gv
vmap <C-]> >gv

" Insert date/time stamp.
map <leader>dt :r! date "+\%Y-\%m-\%d \%H:\%M:\%S"<CR>

" Cycle tabs on OS X.
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" Cycle tabs on Windows and Linux.
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>

" Open this file with the v key.
nmap <leader>v :tabedit $MYVIMRC<CR>

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Strip trailing whitespace with F5.
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Bubble single lines.
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines.
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Visually select the text that was last edited/pasted.
nmap gV `[v`]

" Visual mode search
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

" ----------------------------------------------------------------------------
"                       Clojure
" ----------------------------------------------------------------------------

" Start vimclojure nailgun server (uses screen.vim to manage lifetime).
nmap <silent> <leader>sc :execute "ScreenShell java -cp \"" . classpath . sep . vimclojureRoot . "/lib/*" . "\" vimclojure.nailgun.NGServer 127.0.0.1" <cr>

" Start a generic Clojure repl (uses screen.vim).
nmap <silent> <leader>sC :execute "ScreenShell java -cp \"" . classpath . "\" clojure.main" <cr>

" ============================================================================
"                       Autoload Commands
" ============================================================================

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    filetype on

    " Syntax of these languages is fussy over tabs vs spaces.
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " HTML settings.
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab textwidth=0

    " CSS settings.
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab textwidth=0

    " JavaScript settings.
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab textwidth=0
    autocmd FileType javascript compiler nodelint

    " Haskell settings.
    autocmd FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 smarttab shiftround nojoinspaces

    " Clojure settings.
    autocmd FileType clojure setlocal ts=2 sts=2 sw=2 expandtab textwidth=0
    let vimclojure#WantNailgun = 1

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

    " Python settings
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab textwidth=0
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

    " Wiki settings.
    autocmd BufRead *.wiki set formatoptions+=l lbr

    " For filetypes where whitespace is significant.
    autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

    " Source vimrc changes when this file is saved.
    autocmd bufwritepost .vimrc source $MYVIMRC

endif

" ============================================================================
"                       Functions
" ============================================================================

" Set wrapping for long lines of text.
command! -nargs=* Wrap set wrap linebreak nolist

" Set tabstop, softtabstop and shiftwidth to the same value.
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
finally
    echohl None
  endtry
endfunction

function! <SID>StripTrailingWhitespaces()
    " Preparation: Save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business.
    %s/\s\+$//e
    " Clean-up: Restore previous search history, and cursor position.
    let @/=_s
    call cursor(l, c)
endfunction

" Show syntax highlighting groups for word under cursor.
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Visual search mode searches using the entire selection.
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g') let @s = temp
endfunction

" ============================================================================
"                       Commands not in Muscle Memory
" ============================================================================
