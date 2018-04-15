

set nocompatible


" 各プラグインをインストールするディレクトリ
let s:plugin_dir = expand('~/.vim/bundle/')
" dein.vimをインストールするディレクトリをランタイムパスへ追加
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_dir

" dein.vimがまだ入ってなければ 最初に`git clone`
if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_dir)
endif

if dein#load_state(s:plugin_dir)
  call dein#begin(s:plugin_dir)

  " ここからインストールするプラグインを書いていく
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')




  " インストール後ビルドする場合
  call dein#add('Shougo/vimproc.vim', {
        \ 'build': {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'mac': 'make -f make_mac.mak',
        \     'linux': 'make',
        \     'unix': 'gmake',
        \    },
        \ })

  " 条件によって使ったり使わなかったり制御する場合
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('davidhalter/jedi-vim')
  " 依存関係がある場合

  " 手動でcall dein#source('プラグイン名')して使い始める場合

  " 指定のファイルタイプ使う場合

  " dein.vimで管理して更新だけするリポジトリ（NeoBundleFetchとおなじ）


  " サブディレクトリを指定してdein#add()する場合
  " frozenオプションは自動で更新しない
  " 自分で開発するプラグインの管理に便利
  call dein#local('~/src/github.com/violetyk',
        \ {
        \   'frozen' : 1,
        \   'depends' : [
        \     'kana/vim-gf-user',
        \     'Shougo/neosnippet.vim',
        \     'vim-jp/vital.vim'
        \   ]
        \ },
        \ [
        \   '*.vim',
        \   'neosnippet-*',
        \   'neocomplete-*',
        \   'scratch-utility'
        \ ])
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on


"------------------------------------
" neocomplete.vim
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

nnoremap <Space> :<C-u> source $MYVIMRC<CR>

nnoremap <silent> @u :<C-u>Unite file<CR>
set helplang=en
autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python %

set runtimepath+=~/a/html5.vim
set clipboard=unnamed,autoselect



"------------------------------------
"  メニュー英語化、UTF-8
"------------------------------------
let $LANG='ja_JP.UTF-8'
set encoding=utf-8
source $VIMRUNTIME/delmenu.vim 
set langmenu=none
source $VIMRUNTIME/menu.vim
syntax enable
colorscheme solarized
