" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions

" *************************************************************************** "
" => General
" *************************************************************************** "

" Sets how many lines of history VIM has to remember
set history=500

filetype on
" 根据文件类型选择缩进
filetype indent on
" 根据文件类型选择插件
filetype plugin on

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" *************************************************************************** "
" => VIM user interface
" *************************************************************************** "

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" Set 7 lines to the cursor - when moving vertically using j/k
" 用 j/k 移动行时，保留 7 行在最上或最下
set so=7

" Turn on the Wild menu
" What is wildmenu refers to https://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
" allow you to navigate using <tab> in command line completion
" 以列表模式显示 vim command tab 的补全提示
set wildmenu

" Ignore compiled files
set wildignore+=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Always show current position
set ruler

" Height of the command bar
" 命令行栏的高度
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" 显示行号
set number
" 设置光标线
set cursorline
" 显示当前键入的命令
set showcmd

" 设置鼠标可用
set mouse=a

" 设置搜索结果高亮
set hlsearch
" 设置字符集
set encoding=utf-8


" *************************************************************************** "
" => Colors and Fonts
" *************************************************************************** "

" 语法高亮
syntax on

" 设置颜色
set t_Co=256
" 设置 True Color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php write

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the format of pasted test
" F2 to taggle paste mode
set pastetoggle=<F2> 

"Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

set rtp+=/usr/local/opt/fzf

" *************************************************************************** "
"
" vim-plug 插件管理
"
" *************************************************************************** "

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" vim-easy-align Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" to place, toggle and display marks
Plug 'kshenoy/vim-signature'

" onehalf 主题设置
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" 可以使 nerdtree 的 tab 更加友好些
Plug 'jistr/vim-nerdtree-tabs'

" 用来提供一个导航目录的侧边栏
Plug 'scrooloose/nerdtree'

" 可以在导航目录中看到 git 版本信息"
Plug 'Xuyuanp/nerdtree-git-plugin'

" 查看当前代码文件中的变量和函数列表的插件
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航，Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'

" lightline 状态栏插件
Plug 'itchyny/lightline.vim'

" NerdTree 文件管理器 file system explorer
Plug 'preservim/nerdtree'

" Auto pair bracket
Plug 'jiangmiao/auto-pairs'

" 可以在 vim 中使用 tab 补全
Plug 'vim-scripts/SuperTab'

" solidity plugin
Plug 'tomlion/vim-solidity'

"go 主要插件
"Plug 'fatih/vim-go'

"go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'dgryski/vim-godef'"

" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

" Initialize plugin system
call plug#end()

" 主题设置
colorscheme onehalfdark

" lightline 插件设置
set laststatus=2
let g:lightline = { 'colorscheme': 'onehalfdark'}

" NerdTree 插件设置
" 设置 ctrl + b 出发 NERDTreeToggle
" nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <S-C-e> :NERDTreeToggle<CR>
"map <C-S-E> :NERDTreeToggle<CR>

" vim-go plugin setting
"filetype plugin indent on
"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'
"let g:go_fmt_command='gofmt'
"let g:go_code_completion_enabled=1
"let g:go_highlight_types=1
"let g:go_highlight_fields=1
"let g:go_highlight_functions=1
"let g:go_highlight_function_calls=1
"let g:go_highlight_operators=1
"let g:go_highlight_build_constraints=1
" This command will set the filetype to Go whenever you open a new or existing Go file.
"autocmd BufRead,BufNewFile "*.go" set filetype=go
" This command will disable the use of spaces for tabs, but only in Go files.
"autocmd FileType go setlocal noexpandtab
