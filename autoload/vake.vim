"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/Vake.vim
"VERSION:  0.9
"LICENSE:  MIT

function! vake#Search()
    let i = 0
    let dir = expand('%:p:h').'/'
    while i < g:vake_cdloop
        if !filereadable(dir.g:vake_vakefile)
            let i = i + 1
            let dir = dir.'../'
        else
            break
        endif
    endwhile

    if i != g:vake_cdloop
        return dir
    endif
    return ''
endfunction

function! vake#Vake()
    let dir = vake#Search()
    if dir != ''
        let org = getcwd()
        exec 'silent cd '.dir
        exec 'source '.g:vake_vakefile
        exec 'silent cd '.org
    else
        echo 'No Vakefile.'
    endif
endfunction

function! vake#Edit()
    let dir = vake#Search()
    if dir != ''
        exec 'e '.dir.g:vake_vakefile
    endif
endfunction

function! vake#Template()
    if !filereadable(g:vake_vakefiledir.g:vake_vakefile)
        let org = getcwd()
        exec 'cd '.g:vake_vakefiledir
        call writefile([], g:vake_vakefile)
        exec 'cd '.org
    endif

    exec 'e '.g:vake_vakefiledir.g:vake_vakefile
endfunction

function! vake#Create()
    if !filereadable(g:vake_vakefile)
        if filereadable(g:vake_vakefiledir.g:vake_vakefile)
            call writefile(readfile(g:vake_vakefiledir.g:vake_vakefile), g:vake_vakefile)
        else
            call writefile([], g:vake_vakefile)
        endif
        exec 'e '.g:vake_vakefile
    endif
endfunction

function! vake#compressed(file)
    let s:file = join(readfile(a:file), '')
    call writefile([s:js], '../deploy/m.js')
endfunction
