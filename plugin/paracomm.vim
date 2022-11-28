if get(g:, 'paracomm_disable', 0)
    finish
endif

augroup paracomm
    autocmd!
    autocmd FileType c,cpp call paracomm#install('cCommentStart', 'cComment', 'cCommentL', 'commentt')
    autocmd FileType python call paracomm#install('pythonComment', 'pythonTodo', 'pythonTripleQuotes', 'TSString', 'TSComment')
    autocmd FileType rust call paracomm#install('rustCommentBlock', 'rustCommentLine', 'comment')
    autocmd FileType sh call paracomm#install('shComment', 'comment')
    autocmd FileType vim call paracomm#install('vimLineComment', 'comment')
augroup END
