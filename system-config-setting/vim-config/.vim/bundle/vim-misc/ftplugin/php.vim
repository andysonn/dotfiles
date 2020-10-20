" == "acomment" == {{{
"
"          File:  php.vim
"        Author:  kyo
"      Modifier:  kyo
"      Modified:  2016-06-28
"   Description:  PHP Manual for Vim
"
" --}}}
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_phpmanual")
    finish
endif
let b:did_ftplugin_phpmanual = 1

setlocal keywordprg=:help

set iskeyword=a-z,A-Z,48-57,:,$,-,>,_,\\
if (g:islinux)
    set dictionary-=~/.vim/autocomple_file/php.txt
    set dictionary+=~/.vim/autocomple_file/php.txt
else
    set dictionary-=$VIM/php.txt dictionary+=$VIM/php.txt
endif
set complete-=k complete+=k

"==============================================================================
" test code
" inoremap <expr> -> TestMonths()
" function TestMonths()
    " return '.\<C-X>\<C-O>"
" endfunc

" inoremap <F2> <C-R>=ListMonths()<CR>
" func! ListMonths()
  " call complete(col('.'), ['January', 'February', 'March',
    " \ 'April', 'May', 'June', 'July', 'August', 'September',
    " \ 'October', 'November', 'December'])
  " return ''
" endfunc

" "ctrl+x,ctrl+u触发
" fun! CompleteMonths(findstart, base)
  " if a:findstart
    " " 定位单词的开始处
    " let line = getline('.')
    " let start = col('.') - 1
    " while start > 0 && line[start - 1] =~ '\a'
      " let start -= 1
    " endwhile
    " return start
  " else
    " ' 寻找匹配 'a:base' 的月份
    " let res = []
    " for m in split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec")
      " if m =~ '^' . a:base
    " call add(res, m)
      " endif
    " endfor
    " return res
  " endif
" endfun
" set completefunc=CompleteMonths
