if get(g:, 'paracomm_disable', 0)
    finish
endif

augroup paracomm
    autocmd!
    autocmd FileType c,cpp call paracomm#install('cCommentStart', 'cComment', 'cCommentL', 'comment')
    autocmd FileType python call paracomm#install('pythonComment', 'pythonTodo', 'pythonTripleQuotes', 'comment')
    autocmd FileType rust call paracomm#install('rustCommentBlock', 'rustCommentLine', 'comment')
    autocmd FileType sh call paracomm#install('shComment', 'comment')
    autocmd FileType vim call paracomm#install('vimLineComment', 'comment')
    autocmd FileType lua call paracomm#install('luaComment', 'comment')
augroup END
