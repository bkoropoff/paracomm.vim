if get(g:, 'paracomm_disable', 0)
    finish
endif

augroup paracomm
    autocmd!
    autocmd FileType c,cpp call paracomm#install('cCommentStart', 'cComment', 'cCommentL', 'TSComment')
    autocmd FileType python call paracomm#install('pythonComment', 'pythonTodo', 'pythonTripleQuotes', 'TSString', 'TSComment')
    autocmd FileType rust call paracomm#install('rustCommentBlock', 'rustCommentLine', 'TSComment')
    autocmd FileType sh call paracomm#install('shComment', 'TSComment')
    autocmd FileType vim call paracomm#install('vimLineComment', 'TSComment')
augroup END
