"添加文件说明信息
nnoremap <silent> <C-S-2> ggi/*<CR>
\*******************************************************************************
\<CR>*<CR>*   FileName    :    <C-R>=GetFileName()<ESC>
\<CR>*<CR>*   Author      :    kyo <kyo2018@163.com>
\<CR>*<CR>*   Created     :    <C-R>=GetDateTime()<ESC>
\<CR>*<CR>*   Description :
\<CR>*<CR>
\*******************************************************************************
\<CR>*/<CR><CR>

inoremap <silent> <C-S-1> <ESC>ggi/*<CR>
\*******************************************************************************
\<CR>*<CR>*   FileName    :    <C-R>=GetFileName()<ESC>
\<CR>*<CR>*   Author      :    kyo <kyo2018@163.com>
\<CR>*<CR>*   Created     :    <C-R>=GetDateTime()<ESC>
\<CR>*<CR>*   Description :
\<CR>*<CR>
\*******************************************************************************
\<CR>*/<CR><CR>


"添加函数说明信息
nnoremap <silent> <F4> i<CR>/*<CR>
\*******************************************************************************
\<CR>*<CR>*   Function    :
\<CR>*<CR>*   Input       :
\<CR>*<CR>*   Output      :
\<CR>*<CR>*   Return      :
\<CR>*<CR>*   Description :
\<CR>*<CR>*   Author      :    <C-R>=GetDateTime()<ESC>   by   kyo <kyo2018@163.com>
\<CR>*<CR>
\*******************************************************************************
\<CR>*/<CR><CR>

inoremap <silent> <F4> <CR>/*<CR>
\*******************************************************************************
\<CR>*<CR>*   Function    :
\<CR>*<CR>*   Input       :
\<CR>*<CR>*   Output      :
\<CR>*<CR>*   Return      :
\<CR>*<CR>*   Description :
\<CR>*<CR>*   Author      :    <C-R>=GetDateTime()<ESC>   by   kyo <kyo2018@163.com>
\<CR>*<CR>
\*******************************************************************************
\<CR>*/<CR><CR>
"添加自定义代码块注释，以区别是自己添加的代码
nnoremap <silent> <C-F5> O
\/* kyo Start  <C-R>=GetDateTime()<ESC> */<ESC>o
\/* kyo End <C-R>=GetDateTime()<ESC> */<ESC>O

inoremap <silent> <C-F5> <ESC>O
\/* kyo Start  <C-R>=GetDateTime()<ESC> */<ESC>o
\/* kyo End <C-R>=GetDateTime()<ESC> */<ESC>O

vnoremap <silent> <F5> dO
\#if 0    //kyo Comment Start <C-R>=GetDateTime()<ESC><ESC>o
\#endif   //kyo Comment End   <C-R>=GetDateTime()<ESC><ESC>O<CR><ESC>p

nnoremap <silent> <F5> O
\#if 0    //kyo Comment Start <C-R>=GetDateTime()<ESC><ESC>o
\#endif   //kyo Comment End   <C-R>=GetDateTime()<ESC><ESC>O

inoremap <silent> <F5> <ESC>O
\#if 0    //kyo Comment Start <C-R>=GetDateTime()<ESC><ESC>o
\#endif   //kyo Comment End   <C-R>=GetDateTime()<ESC><ESC>O

" function KyoW3mOpen()
    " let cmd = 'find /D/php/course/manual/php-chunked-xhtml -name \"*'.expand('<cword>').'*"'
    " call exgsearch#open_window()
    " silent exec '1,$d _'
    " let start_line = 1
    " silent exec 'normal ' . start_line . 'g'
    " let title = 'w3m file list'
    " let result = system(cmd)
    " " echo result
    " let leindex = stridx(result, '\n')
    " if leindex == -1
        " return
    " endif

    " if stridx(result, '\n', leindex + 1)  == -1
        " call KyoW3m(result)
        " return
    " endif

    " let header = '---------- ' . title . ' ----------'
    " let start_line += 1
    " let text = header . '\n' . result
    " silent put =text
    " let end_line = line('$')
" endfunction

" function KyoW3m(path)
    " if a:path == ''
        " silent exec '!w3m '.getline('.')
    " else
        " silent exec '!w3m '.a:path
    " endif
    " silent exec 'redraw!'
    " call exgsearch#close_window()
" endfunction

" nnoremap ,w3 :call KyoW3mOpen()<CR>
" nnoremap ,w3m :call KyoW3m("")<CR>
