"
" VIM configuration file.
"
" -----------------------------------------------------------------------------
" {{{ neobundle ----------------------------------------------------------------
set nocompatible
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim.git
    call neobundle#rc(expand('~/.bundle'))
endif

NeoBundle 'https://github.com/vim-jp/vimdoc-ja.git'

NeoBundle 'https://github.com/Shougo/vimfiler.git'
NeoBundle 'https://github.com/Shougo/vimproc.git'
NeoBundle 'https://github.com/Shougo/vimshell.git'

NeoBundle 'https://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/osyo-manga/unite-quickfix.git'
NeoBundle 'https://github.com/tsukkee/unite-tag.git'
NeoBundle 'https://github.com/tsukkee/unite-help.git'
NeoBundle 'https://github.com/h1mesuke/unite-outline.git'
NeoBundle 'https://github.com/ujihisa/unite-colorscheme.git'
NeoBundle 'https://github.com/ujihisa/unite-font.git'
NeoBundle 'https://github.com/ujihisa/unite-locate.git'
NeoBundle 'https://github.com/tacroe/unite-mark.git'
NeoBundle 'https://github.com/tacroe/unite-alias.git'
NeoBundle 'https://github.com/hakobe/unite-script.git'
NeoBundle 'https://github.com/mattn/unite-remotefile.git'
NeoBundle 'https://github.com/thinca/vim-unite-history.git'
NeoBundle 'https://github.com/soh335/unite-qflist.git'
NeoBundle 'https://github.com/Sixeight/unite-grep.git'
NeoBundle 'https://github.com/kmnk/vim-unite-svn.git'

NeoBundle 'https://github.com/thinca/vim-quickrun.git'

NeoBundle 'project.tar.gz'
NeoBundle 'surround.vim'
NeoBundle 'taglist.vim'
NeoBundle 'vcscommand.vim'
NeoBundle 'quickrun.vim'

filetype plugin indent on
" }}}
" {{{ display settings --------------------------------------------------------
syntax on
set number
set laststatus=2
set showcmd
set ruler
"set wrap! = nowrap
set foldmethod=marker
set showmatch
set helplang=ja,en

let g:quickrun_config = { 'outputter' : 'unite_quickfix' }

" {{{ show wide-space and space at tail.
if has("syntax")
	syntax on
	function! ActivateInvisibleIndicator()
		syntax match InvisibleJISX0208Space "　" display containedin=ALL
		highlight InvisibleJISX0208Space term=underline ctermbg=gray guibg=#0F0F0F
		syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
		highlight InvisibleTrailedSpace term=underline ctermbg=gray guibg=#0F0F0F
	endf
	augroup invisible
		autocmd! invisible
		autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
	augroup ENDendif
endif
" }}}
" }}}
" {{{ Serch settings ----------------------------------------------------------
set hlsearch
set ignorecase
set smartcase
set incsearch
"set list
" }}}
" {{{ Edit setting -------------------------------------------------------------
" auto input close parentheses
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap { {}<LEFT>

set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup		" don't create backup
set wildchar=<Tab>  " enable tab completion
set nocompatible    " disable vi compatibility function
au FileType * set complete=.,w,b,u,t,i		" reset completion setting

"insert newline by key <CR> in normal mode without entering edit mode.
noremap <CR> o<ESC>

"settings for VimFiler
let g:vimfiler_as_default_explorer = 1
command Vf VimFiler -buffer-name=explorer -split -simple -winwidth=35 -no-quit

" {{{ reload .vimrc by Ctrl-F12
if has("unix")
	noremap <C-F12> :source ~/.vimrc<CR>
elseif has("gui_win32")
	noremap <C-F12> :source $VIM/_gvimrc<CR>
endif
" }}}
" }}}
" {{{ Japanese settings --------------------------------------------------------
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	unlet s:enc_euc
	unlet s:enc_jis
endif
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
set fileformats=unix,dos,mac
if exists('&ambiwidth')
	set ambiwidth=double
endif

if has('multi_byte_ime') || has('xim')
    highlight CursorIM guibg=Red guifg=NONE
endif
"}}}
" {{{ File type settings ------------------------------------------------------
au BufNewFile,BufRead *.bat,*.cmd call DosBatchSettings()
au BufNewFile,BufRead *.c,*.h,*.cpp,*.java,*.js,*.pl,*.cgi call CCommonSettings()
au BufNewFile,BufRead *.c,*.h call CSettings()
au BufNewFile,BufRead *.cpp call CppSettings()
au BufNewFile,BufRead *.java call JavaSettings()
au BufNewFile,BufRead *.js call JavaScriptSettings()
au BufNewFile,BufRead *.coffee call CoffeeScriptSettings()
au BufNewFile,BufRead *.rb call RubySettings()
au BufNewFile,BufRead *.py call PythonSettings()
au BufNewFile,BufRead *.html,*.htm,*.xhtml,*.xml,*.xsl,*.xslt,*.xul call TagCommonSettings()
au BufNewFile,BufRead *.html,*.htm,*.xhtml call HTMLSettings()
au BufNewFile,BufRead *.css call CssSettings()
au BufNewFile,BufRead *.xml call XmlSettings()
au BufNewFile,BufRead *.xul call XulSettings()
au BufNewFile,BufRead *.php call PHPSettings()
au BufNewFile,BufRead *.pl,*.cgi call PerlSettings()
au BufNewFile,BufRead *.tex call LaTeXSettings()
au BufNewFile,BufRead *.s,*.src call AssemblySettings()
au BufNewFile,BufRead *.scm call SchemeSettings()
au BufNewFile,BufRead *.txt call TextSettings()

" {{{ Windows batch file
function! DosBatchSettings()
	set dictionary=$VIMRUNTIME/dict/dosbatch.dict
	noremap <F5> <Esc>:! %<Enter>
endfunction
" }}}
" {{{ C,C++,Java,JavaScript commonness
function! CCommonSettings()
	set cindent
	nnoremap vf ][v[[?^?s*$<CR>
	nnoremap vb /{<CR>%v%0
endfunction
" }}}
" {{{ C
function! CSettings()
	if has("unix")
		set dictionary=$HOME/.vim/dict/c.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/c.dict
	endif
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=ccomplete#Complete
	endif
	nmap <F5> :call MakeC_gcc()<cr>
endfunction
" }}}
" {{{ C++
function! CppSettings()
	:let java_allow_cpp_keywords=1
endfunction
" }}}
" {{{ Java
function! JavaSettings()
	if has("unix")
		set dictionary=$HOME/.vim/dict/j2se14.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/j2se14.dict
	endif
	:let java_highlight_all=1 "Java言語の標準のクラス名をハイライト
	:let java_highlight_debug=1 "デバッグ文のハイライト
	:let java_space_errors=1 "余分な空白に対してハイライト
	:let java_highlight_functions=1 "メソッド宣言文をハイライト
	compiler javac
	nmap <F5> :call MakeJava()<CR>
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=javacomplete#Complete
		set completefunc=javacomplete#CompleteParamsInfo
	endif
endfunction
" }}}
" {{{ JavaScript
function! JavaScriptSettings()
	if has("unix")
		set dictionary=$HOME/.vim/dict/javascript.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/javascript.dict
	endif
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=javascriptcomplete#CompleteJS
	endif
endfunction
" }}}
" {{{ CoffeeScript
function! CoffeeScriptSettings()
	if has("unix")
		set dictionary=$HOME/.vim/dict/javascript.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/javascript.dict
	endif
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=javascriptcomplete#CompleteJS
	endif
endfunction
" }}}
" {{{ Ruby
function! RubySettings()
	"Rubyのときは、タブ幅を2に設定 & タブ文字の代わりに同じ幅の空白文字を入れる
	set nowrap tabstop=2 tw=0 sw=2 expandtab

	"コンパイラ設定(RUBY)
	compiler ruby

	nmap <F5> :call DebugRuby()<cr>

	"<F6>でバッファのRubyスクリプトを実行し、結果をプレビュー表示
	vmap <silent> <F6> :call Ruby_eval_vsplit()<CR>
	nmap <silent> <F6> mzggVG<F6>`z
	map  <silent> <S-F6> :pc<CR>

	"<C-F10>でRubyスクリプトを保存後コマンドプロンプトから実行
	nmap <silent> <C-F6> :w<CR>:!ruby %<CR>
endfunction
" }}}
" {{{ HTML,XHTML,XML,XUL commonness
function! TagCommonSettings()

	"タブ幅を2に設定
	set nowrap tabstop=2 tw=0 sw=2

	"inoremap <expr> " GetDoubleQuotes()
	inoremap <buffer> < <><LEFT>

endfunction
" }}}
" {{{ HTML
function! HTMLSettings()

	"マークアップ記号を補完する
	inoremap <buffer> \" &quot;
    inoremap <buffer> \& &amp;
    inoremap <buffer> \< &lt;
    inoremap <buffer> \> &gt;
    inoremap <buffer> \<Space> &nbsp;

	"<F5>でHtmlを表示する
	nmap <F5> :! %<CR>

	"オムニ補完
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=htmlcomplete#CompleteTags
	endif

endfunction
" }}}
" {{{ Cascading Style Sheets
function! CssSettings()

	"タブ幅を2に設定
	set nowrap tabstop=2 tw=0 sw=2

	"オムニ補完
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=csscomplete#CompleteCSS
	endif

	"キーマップ変更
	inoremap ; ;<CR>
	inoremap : : 
	inoremap { {<CR>}<Esc>0bo
	
endfunction
" }}}
" {{{ XML
function! XmlSettings()

	"オムニ補完
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=xmlcomplete#CompleteTags
	endif
endfunction
" }}}
" {{{ XUL
function! XulSettings()
	set filetype=xul

	"XULの辞書ファイルをセット
	if has("unix")
		set dictionary=$HOME/.vim/dict/xul.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/xul.dict
	endif

	"オムニ補完
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=xmlcomplete#CompleteTags
	endif
endfunction
" }}}
" {{{ Perl
function! PerlSettings()

	"Perlの辞書ファイルをセット
	if has("unix")
		set dictionary=$HOME/.vim/dict/perl.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/perl.dict
	endif

	"キーマップを変更
	nmap <F5> :! perl %<CR>

endfunction

" }}}
" {{{ Python
function! PythonSettings()
	"オムニ補完
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=pythoncomplete#Complete
	endif
endfunction
" }}}
" {{{ PHP
function! PHPSettings()
	"辞書ファイルの設定
	if has("unix")
		set dictionary=$HOME/.vim/dict/PHP.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/PHP.dict
	endif

	"オムニ補完
	if has("autocmd") && exists("+omnifunc")
		"<C-x><C-o>
		set omnifunc=phpcomplete#CompletePHP
	endif

endfunction
" }}}
" {{{ LaTeX
function! LaTeXSettings()

	"四則演算
	inoremap <buffer> \* \times 
	inoremap <buffer> \/ \div 
	inoremap <buffer> \= \equiv 
	inoremap <buffer> \!= \neq 

	"その他演算子
	inoremap <buffer> \<= \leq 
	inoremap <buffer> \>= \geq 
	inoremap <buffer> \<< \ll 
	inoremap <buffer> \>> \gg 
	inoremap <buffer> \+- \pm 
	inoremap <buffer> \-+ \mp 

	inoremap $ $$<LEFT>

	"LaTeXのときは、タブ幅を2に設定 & タブ文字の代わりに同じ幅の空白文字を入れる
	set nowrap tabstop=2 tw=0 sw=2 expandtab

	"辞書ファイルの設定
	if has("unix")
		set dictionary=$HOME/.vim/dict/tex.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/tex.dict
	endif

	"LaTeXをコンパイル
	nmap <C-F5> :! platex %<CR>

	"PDF変換
	nmap <C-F6> :! dvipdfmx %<<CR>

	"句読点を.や,に変換する
	nmap <F12> :call ConvertPunctuation()<CR>

	"/* -- VIM-LaTeX用設定 -- */
	set shellslash

	" grepを持っている場合
	set grepprg=grep\ -nH\ $*

	" OPTIONAL: This enables automatic indentation as you type.
	filetype indent on

	" dviファイル生成コマンド
	let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*'

	" dviファイルビューワー
	let g:Tex_ViewRule_dvi = 'dviout' 

	" pdf生成
	let g:Tex_FormatDependency_pdf = 'dvi,pdf'
	let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
	let g:Tex_ViewRule_pdf = 'C:\Program Files\Adobe\Acrobat 7.0\Acrobat\Acrobat.exe' 

	" jbitex設定
	let g:Tex_BibtexFlavor = 'jbibtex -kanji=sjis'

endfunction
" }}}
" {{{ Assembly
function! AssemblySettings()

	"タブ幅を8に設定
	set nowrap tabstop=8 tw=0 sw=8

endfunction
" }}}
" {{{ Scheme
function! SchemeSettings()
	
	"タブ幅を2に設定
	" set nowrap tabstop=2 tw=0 sw=2

	"辞書ファイルの設定
	if has("unix")
		set dictionary=$HOME/.vim/dict/R5RS.dict
	elseif has("gui_win32")
		set dictionary=$VIMRUNTIME/dict/R5RS.dict
	endif

	"インデントの設定(ボクノス様http://d.hatena.ne.jp/tanakaBox/20070609/1181382818より頂戴)
	set nocindent
	set lisp
	set lispwords=define

	inoremap <expr> <Space> GetSpace()

endfunction
" }}}
" {{{ Text
function! TextSettings()
	set nocindent
	"タブ幅を2, タブ文字の変わりにスペース
	set nowrap tabstop=2 tw=0 sw=2 expandtab
endfunction
" }}}
" }}}
" {{{ Utility functions --------------------------------------------------------
" gcc compiler setting.
function! MakeC_gcc()
	:w
	:compiler gcc
	:set makeprg=gcc
	" :make -Wall -g %
	:make -Wall --std=c99 %
	:cw
endfunction

" }}}
