" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------

" function! KyoCreateCtags()
    " :silent !ctags -Rn --c++-kinds=+p --fields=+ialS --extra=+q
    " :redraw!
" endfunction

" 对浏览代码非常的方便,可以在函数,变量之间跳转等
"映射,tg执行ctags命令
nmap <silent> ,tg :!ctags -Rn --c++-kinds=+p --fields=+ialS --extra=+q .<cr><cr>
vmap <silent> ,tg :!ctags -Rn --c++-kinds=+p --fields=+ialS --extra=+q .<cr><cr>

"生成系统头文件符号ctags
nmap <silent> ,ts :!ctags -Rn --c++-kinds=+p --fields=+ialS --extra=+q -o ~/.vim/systags /usr/include /usr/local/include<cr><cr>
vmap <silent> ,ts :!ctags -Rn --c++-kinds=+p --fields=+ialS --extra=+q -o ~/.vim/systags /usr/include /usr/local/include<cr><cr>
"vmap <silent> ,tg :!ctags -R --fields=+lS<cr><cr>
set tags=~/.vim/systags
" set tags+=./tags                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）

"解决ctrl+]跳转默认跳到第一个关键词
" nmap <C-]>  :ts <C-R>=expand("<cword>")<CR><CR>

"set tags+=~/.vim/tmptags
"获取输入路径创建ctags
function KyoTags()
    let str = input("please input : ", getcwd())
    call system("ctags -Rn --c++-kinds=+p --fields=+ialS --extra=+q -o ~/.vim/tmptags ".str)
endfunction

nmap ,ck :call KyoTags()<CR>

