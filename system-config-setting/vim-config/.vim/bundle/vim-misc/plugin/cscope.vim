" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
" -----------------------------------------------------------------------------
" 用Cscope自己的话说 - 你可以把它当做是超过频的ctags
if has("cscope")
    "设定使用quickfix窗口显示cscope结果
    set cscopequickfix=s-,c-,d-,i-,t-,e-

    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag
    "如果你想反向搜索顺序设置为1
    set csto=0

    "创建当前目录cscope数据库
    nmap ,sd  :!cs<CR>:<ESC>
    "把cscope数据库导入vim
    if (g:islinux)
        nmap ,sa  :cs add ~/.vim/cscope/cscope.out .<CR>:<ESC>
        "打开vim自动把cscope数据库导入vim
        "cs add /root/.vim/cscope/cscope.out .
        "创建当前目录cscope数据库并且导入vim
        nmap ,so  :!cs<CR><CR>:cs add ~/.vim/cscope/cscope.out .<CR>:<ESC>
    else
        nmap ,sa  :cs add $VIM/cscope/cscope.out .<CR>:<ESC>
        "打开vim自动把cscope数据库导入vim
        "cs add $VIM/cscope/cscope.out .
        "创建当前目录cscope数据库并且导入vim
        nmap ,so  :!cs<CR><CR>:cs add $VIM/cscope/cscope.out .<CR>:<ESC>
    endif
    "映射查找按键
    nmap <F4>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <F4>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <F4>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <F4>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <F4>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <F4>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <F4>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <F4>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

endif

"映射quick窗口上下结果选择按键
nmap <F6>,  :cn<CR>:<ESC>
nmap <F6>.  :cp<CR>:<ESC>
