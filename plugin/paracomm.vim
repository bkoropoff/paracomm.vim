if get(g:, 'paracomm_disable', 0)
    finish
endif

augroup paracomm
    autocmd!
    autocmd FileType c,cpp call paracomm#install('cCommentStart', 'cComment', 'cCommentL')
    autocmd FileType python call paracomm#install('pythonComment', 'pythonTodo')
    autocmd FileType rust call paracomm#install('rustCommentBlock', 'rustCommentLine')
    autocmd FileType sh call paracomm#install('shComment')
    autocmd FileType vim call paracomm#install('vimLineComment')
augroup END
