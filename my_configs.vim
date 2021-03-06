" Disable ycm
let g:loaded_youcompleteme = 1 
" set pyxversion=3
" let g:python3_host_prog="c:/Users/yongnianliu/AppData/Local/Programs/Python/Python36-32/python.exe"
call plug#begin('~/.vim_runtime/my_plugins')
Plug 'Valloric/YouCompleteMe'
Plug 'vim-scripts/a.vim'
Plug 'mbbill/undotree'
Plug 'easymotion/vim-easymotion'
Plug 'vim-syntastic/syntastic'
Plug 'tbastos/vim-lua'
Plug 'skywind3000/asyncrun.vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'yianwillis/vimcdoc'
" Plug 'vim-scripts/gtags.vim'
" shader highlight
Plug 'tikhomirov/vim-glsl'
Plug 'beyondmarc/hlsl.vim'
Plug 'vim-scripts/cg.vim'
" color
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'vim-scripts/taglist.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
" Plug 'junegunn/fzf.vim'
" Plug 'chusiang/vim-sdcv'
" Plug 'majutsushi/tagbar'
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'neovim/pynvim'
" Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
" Plug 'skywind3000/quickmenu.vim'
" Plug 'jremmen/vim-ripgrep'
" Plug 'rust-lang/rust.vim'
" Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

""""""""""""""""""""""""""""""
" => colorcheme
""""""""""""""""""""""""""""""
try
    colorscheme gruvbox 
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ycm_global_ycm_extra_conf='~/.vim_runtime/my_plugins/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf='~/.vim_runtime/my_plugins_config/.ycm_extra_conf.py'
" YouCompleteMe
" nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap <M-g> <Esc>:YcmCompleter GoToDefinition<CR>
" nnoremap <C-p> <Esc>:FZF<CR>
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
" let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ "vim":1,
			\ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 配置 gtags 的参数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" choose a favorite key to show/hide quickmenu
" uoremap <silent><F12> :call quickmenu#toggle(0)<cr>

" enable cursorline (L) and cmdline help (H)
" let g:quickmenu_options = "HL"

" " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" " 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = '.tags'

" " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags

" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" " 检测 ~/.cache/tags 不存在就新建
" if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
" endif

" let $GTAGSLABEL = 'native-pygments'
" if has('win32')
"     let $GTAGSCONF = 'D:\software\glo663wb\share\gtags\gtags.conf'
" elseif has('unix')
" elseif has('mac')
" endif

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 配置CPP语法高亮 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

" height ligth cusor
set bg=dark
set cursorline
set cursorcolumn
 
highlight CursorLine cterm=none ctermbg=236
highlight CursorColumn cterm=none ctermbg=236

" let g:deoplete#enable_at_startup = 1

"set cscopetag " 使用 cscope 作为 tags 命令
"set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
""gtags.vim 设置项
"let GtagsCscope_Auto_Load = 1
"let CtagsCscope_Auto_Map = 1
"let GtagsCscope_Quiet = 1
"let g:Gtags_Auto_Map = 0
" nmap <F12> :GtagsCursor<CR>

" 防止水平滑动的时候失去选择
xnoremap <  <gv
xnoremap >  >gv
map <leader>u :UndotreeToggle<cr>
" nnoremap <F5> :update<CR>:source %<CR>
