let s:notsym = "[^~`!@#$%^&*(){}[\\];,<.>/?+-=\"'\\\\|]"

function! s:SynNameAtCur()
    return synIDattr(synID(line('.'), col('.'), 0), "name")
endfunction

function! s:IsComm()
    normal! $
    if get(b:paracomm_items, s:SynNameAtCur(), '') == ''
        return 0
    endif
    normal! ^
    return get(b:paracomm_items, s:SynNameAtCur(), '') != ''
endfunction

function! s:IsCommEmpty()
    let [_, col] = searchpos(s:notsym, 'nzW', line('.'))
    return col == 0 || trim(getline('.')[col-1:]) == ''
endfunction

function! s:EndComm(after)
    let sense = s:IsCommEmpty()
    while 1
        if !s:IsComm() || s:IsCommEmpty() != sense
            break
        endif
        if line('.') == line('$')
            return
        endif
        normal! j^
    endwhile
    if !s:IsComm() || !a:after
        normal! k^
    endif
endfunction

function! s:StartComm(before)
    let sense = s:IsCommEmpty()
    while 1
        if !s:IsComm() || s:IsCommEmpty() != sense
            break
        endif
        if line('.') == 1
            return
        endif
        normal! k^
    endwhile
    if !s:IsComm() || !a:before
        normal! j^
    endif
endfunction

function! s:NextParagraph(c)
    if s:IsComm()
        for _ in range(a:c)
            if s:IsCommEmpty()
                call s:EndComm(1)
            endif
            call s:EndComm(1)
        endfor
    else
        exec 'normal!' a:c.'}'
    endif
endfunction

function! s:PrevParagraph(c)
    if s:IsComm()
        for _ in range(a:c)
            if s:IsCommEmpty()
                call s:StartComm(1)
            endif
            call s:StartComm(1)
        endfor
    else
        exec 'normal!' a:c.'{'
    endif
endfunction

function! s:Paragraph(inner, c)
    if s:IsComm()
        call s:StartComm(0)
        mark <
        if a:inner
            " Dutifully replicate (weird) standard behavior
            let inner = a:c % 2 == 1
            let c = (a:c + 1) / 2
        else
            let inner = 0
            let c = a:c
        endif
        for i in range(1, c)
            call s:EndComm(!inner || i < c)
            call s:EndComm(i < c)
        endfor
        mark >
        normal! `<V`>
    else
        exec 'normal! v'.a:c.(a:inner ? 'ip' : 'ap')
    endif
endfunction

function! paracomm#install(...)
    let items = {}
    for item in a:000
        let items[item] = item
    endfor

    let b:paracomm_items = items

    noremap <buffer><silent> { :<c-u>call <sid>PrevParagraph(v:count1)<cr>
    noremap <buffer><silent> } :<c-u>call <sid>NextParagraph(v:count1)<cr>
    onoremap <buffer><silent> ip :<c-u>call <sid>Paragraph(1, v:count1)<cr>
    onoremap <buffer><silent> ap :<c-u>call <sid>Paragraph(0, v:count1)<cr>
    xnoremap <buffer><silent> ip :<c-u>call <sid>Paragraph(1, v:count1)<cr>
    xnoremap <buffer><silent> ap :<c-u>call <sid>Paragraph(0, v:count1)<cr>
endfunction
