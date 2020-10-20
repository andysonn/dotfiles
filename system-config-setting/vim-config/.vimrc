" ==============================================================================
" 基本配置
" ==============================================================================

"关闭兼容模式，完全应用VIM所有扩展功能， 不兼容vi
set nocompatible

"帮助文档显示为中文
set helplang=cn

" 注："<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如<Leader>t
" 指在常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一
" 秒内，而<Leader>cs是先按"\"键再按"c"又再按"s"键
" 设置<leader>键值
let mapleader=','

"-------------------------------------------------------------------------------
" 操作系统的信息和GVIM信息获取
"-------------------------------------------------------------------------------

"标识是否为windows系统的全局变量
let g:iswindows = 0
"标识是否为linux系统的全局变量
let g:islinux = 0
"标识是否为OSX系统的全局变量
let g:isosx = 0

"判断当前使用的操作系统 设置全局变量值
if (has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
elseif has("macunix")
    let g:isosx = 1
else
    let g:islinux = 1
endif

"判断当前是否使用GVIM 并且设置全局变量来标识
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

"根据当前系统自动转化路径分隔符
function g:Kyo_Path_Separator(path)
    if g:iswindows
        return substitute(a:path, '/', '\', 'g')
    endif
    return a:path
endfunction

"判断windows系统VIM配置脚本是否设置自定义路径, 如果没有设置则设置VIM工作路径
if !exists('g:custom_path') && g:iswindows
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
    set runtimepath+=$VIM/vimfiles/after,$HOME/.vim/after
endif

"-------------------------------------------------------------------------------
" 语言环境和字符编码设置
"-------------------------------------------------------------------------------
"总是使用英文菜单
set langmenu=none

" 设置VIM内部字符编码为utf-8
set encoding=utf-8
"在终端下使用的字符编码
set termencoding=utf-8
"设置新建文件保存时使用的编码
set fileencoding=utf-8
"设置打开文件的支持编码
set fileencodings=ucs-bom,utf-8 ",utf-16le
set fileencodings+=cp936,gb18030,big5,euc-jp,euc-kr,gbk,latin-1

"如果是windows系统又开启支持中文编码特性
if g:iswindows && has('multi_byte')
    "windows cmd.exe 终端字符编码是cp850
    "如果是Powershell为windows的输出终端，则这里也要设置utf8
    set termencoding=cp850
    "设置vim内部字符编码为utf8, 很多脚本文件会依赖
    setglobal fileencoding=utf-8
endif

"脚本编码为utf-8
scriptencoding utf-8

"设置文件行结束符格式
"设置新文件的<EOL>格式 unix为换行符，dos为回车+换行符
set fileformat=unix
"文件自动识别行结束符的集合
" set fileformats=unix,dos,mac
set fileformats=unix

" ==============================================================================
" Bundle 插件配置
" ==============================================================================

" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 如果想在 windows 安装就必需先安装 'git for window'，可查阅网上资料

" vundle#begin vundle配置开始 此配置必须设置，否则vundle会设置失败
filetype off

"vimfiles/tools         依赖的工具路径
".vim/tools             依赖的工具路径
".vimrc_plugins         通用插件配置文件
".vimrc_plugins_local   本地插件配置文件
"vimfiles/bundle/       插件所在文件夹
".vim/bundle/           插件所在文件夹

" 设置依赖的工具路径，Vundle的路径
if exists('g:custom_path')
    let g:tools_path = g:custom_path.'/vimfiles/tools/'
    exec 'set rtp+='.fnameescape(g:custom_path.'/vimfiles/bundle/vundle/')
    call vundle#rc(g:custom_path.'/vimfiles/bundle/')
else
    let g:tools_path = $HOME.'/.vim/tools/'
    exec 'set rtp+='.fnameescape($HOME.'/.vim/bundle/vundle/')
    call vundle#rc($HOME.'/.vim/bundle/')
endif

" 加载 .vimrc.plugins 和 .vimrc_plugins_local配置文件
if exists('g:custom_path')
    let vimrc_plugins_path = g:custom_path.'/.vimrc.plugins'
    let vimrc_plugins_local_path = g:custom_path.'/.vimrc.plugins.local'
else
    let vimrc_plugins_path = $HOME.'/.vimrc.plugins'
    let vimrc_plugins_local_path = $HOME.'/.vimrc.plugins.local'
endif
if filereadable(expand(vimrc_plugins_path))
    exec 'source ' . fnameescape(vimrc_plugins_path)
endif
if filereadable(expand(vimrc_plugins_local_path))
    exec 'source ' . fnameescape(vimrc_plugins_local_path)
endif

" vundle#end "vundle设置结束 开启插件 必须设置以下两选项
filetype plugin indent on
"开启自动语法高亮
syntax on

" ==============================================================================
" 默认配色方案
" ==============================================================================
"设置VIM显示背景
if g:isGUI
    set background=dark
else
    set background=dark
    "设置终端打开VIM 显示颜色数目为256
    set t_Co=256
    let g:solarized_termcolors = 256
endif
"
colorscheme solarized
" colorscheme exlightgray
"
"注释颜色
" hi Comment  guifg=#999999
"常量颜色
" hi Constant guifg=#CD00CD
"#E00CE0
"hi Identifier  guifg=#0000CD
"while for等颜色
" hi Statement    guifg=#BF2624
"关键词类型颜色
" hi Type        guifg=#00CD00
"guibg=#39CB39
"转义后字符颜色
" hi Special  guifg=#FB0C4B
"include宏等的颜色
" hi PreProc guifg=#0000CD
"guibg=#0000FF
"搜索匹配的颜色
" hi Search guifg=#FFFFFF guibg=#BF2624
"guibg为背景颜色，guifg为普通字体颜色
" hi Normal  guifg=#000000 guibg=#F8F8DB
"行号的颜色
" hi LineNr   guifg=#BD871D
"光标的颜色
" hi Cursor   guibg=#000000
"状态栏的颜色
"hi StatusLine guifg=#00FF00
"hi StatusLineNC guifg=#33FF33

" ==============================================================================
" 常规设置
" ==============================================================================

"删除旧的备份，备份当前文件
set backup
" 备份当前文件，写入后删除
"set writebackup
"模式匹配被写入的文件名，备份文件不会被创建
"set backupskip
"设置无备份文件
"set nobackup
"设置无临时文件
"set noswapfile

"如果备份文件和新写入的文件同时丢失，可以尝试:recover 修复
"如果备份文件创建失败，写入不会进行，除非命令加上!

" 设置备份文件和临时交换文件路径
let data_dir = $HOME.'/.data/'
let backup_dir = data_dir . 'backup'
let swap_dir = data_dir . 'swap'
if finddir(data_dir) == ''
    silent call mkdir(data_dir)
endif
if finddir(backup_dir) == ''
    silent call mkdir(backup_dir)
endif
if finddir(swap_dir) == ''
    silent call mkdir(swap_dir)
endif
unlet backup_dir
unlet swap_dir
unlet data_dir

"备份文件存放位置
set backupdir=$HOME/.data/backup
"临时交换文件存放位置
set directory=$HOME/.data/swap

"用于把过滤命令输出存到临时文件的字符串
set shellredir=>%s\ 2>&1
"命令历史保存数
set history=50
"多少毫秒数内没有任何输入，将交换文件写入磁盘 默认值为4000
set updatetime=1000
"auto read same-file change ( better for vc/vim change )
"其它工具修改了vim正在编辑的文件，自动重新读入
set autoread
"用于搜索的最大内存量 最大值大约为2000000 超过为无限制
set maxmempattern=1000

"-------------------------------------------------------------------------------
" 鼠标和选择的行为配置
"-------------------------------------------------------------------------------

"设置鼠标行为为xterm
"mswin行为(mswin.vim)不兼容因为里面使用了ctrl+c ctrl+v ctrl+x
behave xterm
if &term =~ 'xterm'
    "所有模式下都支持鼠标
    set mouse=a
endif

" ==============================================================================
" 选项设置 (set all)
" ==============================================================================

" ------------------------------------------------------------------
" Desc: Visual
" ------------------------------------------------------------------
"显示行号 number/nonumber
set nu
"自动换行 nowrap为取消自动换行
set wrap
"光标上下两侧最少保留的屏幕行数 简称so
"如果设置为2，则光标移动到最上或最下第二行就开始上拉或下拉显示
"默认为0
set scrolloff=2
"如果设置了nowrap 则可以设置水平sidescrolloff(siso)
"set sidescrolloff=2

"如果版本大于7.3
if v:version >= 703
    "打开文件或切换缓冲区会改变当前工作目录的值
    "开启会影响某些插件的使用
    set noacd
endif

"如果使用的是GVIM 设置GVI默认显示的字体
if g:isGUI
    "创建autocmd命令使用的命令组名
    augroup gui_font
        "检查并设置显示字体
        "注意：getfontname函数只能用在GUIEnter后
        au!
        au GUIEnter * call s:set_gui_font()
    augroup END

    "gvim 取消按ESC 叮叮当响 和闪屏
    set vb t_vb=
    au GuiEnter * set t_vb=

    "根据不同环境设置默认显示字体的函数
    function! s:set_gui_font()
        if has('gui_gtk2')
            if getfontname( 'DejaVu Sans Mono\ Bold' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ Bold\ 18
            elseif getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 18
            else
                set guifont=Luxi\ Mono\ 12
            endif
        elseif has('x11')
            " Also for GTK 1
            set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
        elseif g:isosx
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono:h15
            endif
        elseif g:iswindows
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono:h12:cANSI
            elseif getfontname( 'Consolas' ) != ''
                " this is the default visual studio font
                set guifont=Consolas:h11:cANSI
            else
                set guifont=Lucida_Console:h12:cANSI
            endif
        endif
    endfunction
endif

" ------------------------------------------------------------------
" Desc: Vim UI
" ------------------------------------------------------------------

"命令行补全以增加模式运行 使用Tab补全 会在命令行上方显示出相关命令
"简称wmnu
set wildmenu
"在屏幕最后一行显示部分的命令 如果终端慢建议关闭
"set showcmd
"关闭屏幕最后一行显示命令功能
set noshowcmd
"显示光标位置的行号和列号，逗号分隔，如果有空间还会显示文件中相对位置
set ruler
"允许改变不保存缓冲区
set hidden
"缩短信息以避免按任意键提示 去掉欢迎界面
set shortmess=aoOtTI
"执行宏等屏幕不会重画，推迟刷新标题等，提高速度
set lazyredraw
"方便浏览最后一行文字换行
"for easy browse last line with wrap text
set display+=lastline
"命令行使用的屏幕行数 默认值为1
set cmdheight=1
"总是显示状态行
set laststatus=2
"设置命令行和状态栏
set statusline=%F%m%r\ ASCII=\%b,HEX=\%B,%l,%c%V\ %L-%p%%
        "设置在状态行显示的信息如下：
            "   %F              当前文件名
            "   %m              当前文件修改状态
            "   %r              当前文件是否只读
            "   %Y              当前文件类型
            "   %{&fileformat}  当前文件编码
            "   %b              当前光标处字符的ASCII码值
            "   %B              当前光标处字符的十六进制值
            "   %l              当前光标行号
            "   %c              当前光标列号
            "   %V              当前光标虚拟列号(根据字符所占字节数计算)
            "   %p              当前行占总行数的百分比
            "   %%              百分号
            "   %L              当前文件总行数
            "
"设置窗口的标题 依赖title选项
set titlestring=%t\ (%{expand(\"%:p:.:h\")}/)

"如果GVIM 设置窗口大小
if g:isGUI
    "设置默认打开窗口显示多少行 显示多少列
    if exists('+lines')
        set lines=40
    endif
    if exists('+columns')
        set columns=130
    endif

    "如果是windows操作系统启动时最大化窗口
    if g:iswindows
        "指定窗口出现的位置，坐标原点在屏幕左上角
        " winpos 100 10
        au GUIEnter * simalt ~x
    endif
endif

"在插入模式里,补全函数时显示函数参数
set showfulltag

"设置GVIM 显示的选项
if g:isGUI
    "取消显示菜单栏和工具栏
    set guioptions-=m
    set guioptions-=T
    set guioptions+=r
"可以通过+=和-=再添加和删除选项
"m       使用菜单栏
"T       使用工具栏
"a       自动选择 在可视模式或扩展可视模式选取内容自动复制
         "会自动抽出到*选择寄存器里
"P       类型a功能，只是抽出到+寄存器
"A       类似a功能, 只能在无模式下选择
"M       不执行系统菜单脚本 $VIMRUNTIME/menu.vim
"r       右边的滚动条总是存在
"R       垂直分割窗口，右边的滚动条总是存在
"l       左边的滚动条总是存在
"L       垂直分割窗口，左边的滚动条总是存在
"b       底部水平滚动条总是存在，大小取决最长的可见行
"h       限制水平滚动条的大小为光标所在行的长度
endif

"如果在windows gvim  乱码解决方法
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.UTF-8
endif

" =============================================================================
"                     << windows 下解决 Quickfix 乱码问题 >>
" =============================================================================
" windows 默认编码为 cp936，而 Gvim(Vim) 内部编码为 utf-8，所以常常输出为乱码
" 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码，以解决输出乱码问题
" 但好像只对输出信息全部为中文才有满意的效果，如果输出信息是中英混合的，那可能
" 不成功，会造成其中一种语言乱码，输出信息全部为英文的好像不会乱码
" 如果输出信息为乱码的可以试一下下面的代码，如果不行就还是给它注释掉
if g:iswindows
    function QfMakeConv()
        let qflist = getqflist()
        for i in qflist
           let i.text = iconv(i.text, "cp936", "utf-8")
        endfor
        call setqflist(qflist)
     endfunction
     au QuickfixCmdPost make call QfMakeConv()
endif

"set cursorline      "开启高亮行
"设置高亮行颜色配置
"hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white
"开启高亮列
"set cursorcolumn
"设置高亮列颜色配置
"hi Cursorcolumn cterm=NONE ctermbg=black ctermfg=white
"设置80高亮
set cc=80
"设置一行超过80列高亮颜色配置 80列分隔线颜色
"hi ColorColumn ctermbg=Black guibg=Black
"启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" ------------------------------------------------------------------
" Desc: Text edit
" ------------------------------------------------------------------
"在插入模式下允许退格所有字符
set backspace=indent,eol,start
"自动缩进 autoinent
set ai
"开启新行时智能自动缩进 适用于C语言 smartindent
set si
"插入模式下将tab转化成空格
set expandtab
"设置<>或=缩进命令一次缩进为多少个空格
set shiftwidth=4
"设置tab键对应多少个空格
set tabstop=4
"设置退格键可以删除一个tab对应的空格数
set softtabstop=4
"指定退格键可以删除一个shiftwidth宽度的空格
set smarttab

"应用在块可视模式，光标可以定位在不是真实字符上
set ve=block

"C语言缩进风格
"set cindent
"按=自动缩进的选项
set	cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,ts
set cinoptions+=is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30
" default '0{,0},0),:,0#,!^F,o,O,e' disable 0# for not ident preprocess
" set cinkeys=0{,0},0),:,!^F,o,O,e
"cinoptions 会重新缩进C语言 查看help cinoptions-values得到帮助设置
" N代表任何数字
" N         缩进N个空格
" -N        向左缩进N个空格
" Ns        N倍shiftwidth个空格
" -Ns       向左N倍shiftwidth个空格

"官方diff设置
set diffexpr=g:MyDiff()
function! g:MyDiff()
    let opt = '-a --binary -w '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    silent execute '!' .  'diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction


"ctrl + A / ctrl + x 在当前光标之上的字母或数值进行加减改变
"nrformats 选项设置ctrl+a和ctrl+x加减模式
    "alpha      对字母进行递增或递减
    "octal      对0开头数值按八进制形式递增或递减
    "hex        对0x或0X开始的数值按十六进制递增或递减
"set nf=alpha,octal,hex
"设置ctrl+a和ctrl+x不递增或递减
set nf=

" ------------------------------------------------------------------
" Desc: Fold text
" ------------------------------------------------------------------
"foldmethod 设置当前窗口使用的折叠方式
    "manual     手动建立折叠
    "indent     相同缩进距离的行构成折叠
    "expr       foldexpr给出第行的折叠级别
    "marker     标志用于指定折叠
    "syntax     语言高亮项目指定折叠(巨坑会造成VIM卡顿)
    "diff       没有改变的文本构成折叠
set foldmethod=indent
"设置折叠开始和结束标志
set foldmarker={,}
"设置折叠级别 高于此级别的折叠会被关闭
set foldlevel=9999
"设置diff模式选项
set diffopt=filler,context:9999
    "filler     显示填充行 使相同位置多出文本的其它窗口同步
    "context    在更改和包含未更改行的折叠之间保留上下文行数
    "icase      忽略文本大小写更改
    "iwhite     忽略空白字符数目的更改
    "horizontal 以水平分割启动diff模式
    "vertical   以垂直分割启动diff模式

" ------------------------------------------------------------------
" Desc: Search
" ------------------------------------------------------------------

"插入括号时，短暂地跳转到匹配的对应括号
"此屏幕能看到匹配的括号才会跳转
set showmatch
"显示配对括号的时间 时间单位为十分之一秒数
set matchtime=0

"搜索时会实时匹配并跳转显示 但是按ESC或没有匹配到会回到原来位置
set incsearch
"高亮搜索关键词
set hlsearch " highlight search terms
"忽略大小写搜索
set ignorecase
"如果关键词包含大写不使用ignorecase选项
set smartcase

"使得注释换行时自动加上前导的空格和星号
" set formatoptions=tcqro
"设定在任何模式下鼠标都可用
set mouse=
"在单词中间断行
"set nolinebreak
"
" set this to use id-utils for global search
"设置grep命令使用的程序
set grepprg=lid\ -Rgrep\ -s
"识别grep命令输出格式
set grepformat=%f:%l:%m

" ==============================================================================
" 自动命令设置(Auto Command)
" ==============================================================================

"如果autocmd开启
if has('autocmd')
    "创建一个自动命令的组 组名为ex
    augroup ex

        "删除本组所有自动命令
        au!

        " ------------------------------------------------------------------
        " Desc: Buffer 缓冲区操作事件
        " ------------------------------------------------------------------

        " 当编辑一个文件时， 光标总是会跳转到上一次修改保存的位置
        " line("'\"") 获取上一次编辑退出的光标所在行号
        " line("$") 获取当前文件最后一行号
        " 当最后修改保存的光标失效或在事件处理程序中则不跳转光标
        " (当gvim删除一个文件时)
        au BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
        " 设置ctags查找tags文件到当前目录下查找
        au BufNewFile,BufEnter * set cpoptions+=d
        " 确保每种文件都语法高亮显示
        " ensure every file does syntax highlighting (full)
        au BufEnter * :syntax sync fromstart
        " for avs syntax file. 对于avs文件设置avs语法
        au BufNewFile,BufRead *.avs set syntax=avs

        " ------------------------------------------------------------------
        " Desc: file types 文件类型事件
        " ------------------------------------------------------------------

        " 对所有文本文件设置一行中最多字符数 会根据此数字自动在空白位置折行
        au FileType text setlocal textwidth=78

    augroup END
endif

" ==============================================================================
" 按键映射 (Key Mappings)
" ==============================================================================

" 不使用Ex mode，将Q格式化 不会进入Ex mode
map Q gq

"关闭搜索高亮
" nnoremap <F8> :let @/=""<CR>
nnoremap <leader>nh :let @/=""<CR>
"
"用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"设置分屏窗口之间切换
nnoremap <C-S-j> <C-W><Up>
nnoremap <C-S-k> <C-W><Down>
nnoremap <C-S-h> <C-W><Left>
nnoremap <C-S-l> <C-W><Right>

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

" 开关粘贴模式(保留粘贴原文格式)
nmap <leader>pa :set paste!<CR>

" 开关行号显示
nmap <leader>nu :set number!<CR>

" -----------------------------------------------------------------------------
"  自动补全（,",{,［
" -----------------------------------------------------------------------------
""nnoremap <silent> ( i()<ESC>i
""inoremap <silent> ( ()<ESC>i

""nnoremap <silent> { i{}<ESC>i
""inoremap <silent> { {}<ESC>i

""nnoremap <silent> [ i[]<ESC>i
""inoremap <silent> [ []<ESC>i


" -----------------------------------------------------------------------------
"  复制粘贴
" -----------------------------------------------------------------------------
"相当于window下的复制粘贴, 必须要安装gnome-vim才有效
if (g:isGUI)
    vnoremap <silent> !y "+y
    nnoremap <silent> !p "+p
endif

"文件之间复制粘贴
if (g:islinux)
    vnoremap  "y    :w! /tmp/kyo.vim<CR>
    nnoremap  "y    :w! /tmp/kyo.vim<CR>
    nnoremap  "p    :r  /tmp/kyo.vim<CR>
else
    vnoremap  "y    :w! $VIM/tmp/kyo.vim<CR>
    nnoremap  "y    :w! $VIM/tmp/kyo.vim<CR>
    nnoremap  "p    :r  $VIM/tmp/kyo.vim<CR>
endif

" ==============================================================================
" local setup 本地配置
" ==============================================================================

let vimrc_local_path = $HOME.'/.vimrc.local'
if exists('g:exvim_custom_path')
    let vimrc_local_path = g:exvim_custom_path.'/.vimrc.local'
endif

if filereadable(expand(vimrc_local_path))
    exec 'source ' . fnameescape(vimrc_local_path)
endif
