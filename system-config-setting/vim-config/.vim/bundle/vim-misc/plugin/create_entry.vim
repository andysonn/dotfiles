" -----------------------------------------------------------------------------
"  C语言公共模块
" -----------------------------------------------------------------------------

function Kyo_Create_Main()
    let s = ['#include <stdio.h>', '']
    " call add(s, 'int main(void)')
    let s += ['int main(void)', '{']
    let s += ['    return 0;', '}']
    " let s = ['#include <stdio.h>', '', 'int main(void)', '{', '', '    return 0;', '}']
    echo s
    " call setline(1, s)
    " :exe 'normal 4jO'
endfunction


nnoremap ,ks  i#include <stdio.h><CR>#include <string.h><CR>
\#include <stdlib.h><CR>#include <sys/types.h><CR>#include <sys/stat.h><CR>
\#include <errno.h><CR>#include <fcntl.h><CR>#include <unistd.h><CR><CR>
\int main(void)<CR>{<CR>return 0;<ESC>v=o}<ESC>=kO

nnoremap ,ka i#include <stdio.h><CR><CR>int main(void)<CR>{<CR>return 0;<ESC>v=o}<ESC>v=kO

nnoremap ,kc i#include <iostream><CR><CR>using namespace std;<CR><CR>int main(void)<CR>{<CR>return 0;<ESC>v=o}<ESC>v=kO


" -----------------------------------------------------------------------------
"  PHP语言公共模块
" -----------------------------------------------------------------------------
function Kyo_Create_Command_PHP()
    let command_path = system('echo -n $(which php)')
    let s = ['#!'.command_path, '<?PHP']
    call setline(1, s)
    :exe 'normal 2jo'
    :set ft=php
endfunction

nnoremap ,pc :call Kyo_Create_Command_PHP()<CR>
