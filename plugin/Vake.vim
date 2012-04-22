"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/Vake.vim
"VERSION:  0.9
"LICENSE:  MIT

if exists("g:loaded_vake")
    finish
endif
let g:loaded_vake = 1

let s:save_cpo = &cpo
set cpo&vim

let g:vake_plugindir = expand('<sfile>:p:h:h').'/'
let g:vake_templatedir = g:vake_plugindir.'template/'

if !exists("g:vake_autofile")
    let g:vake_autofile = []
endif
if !exists("g:vake_cdloop")
    let g:vake_cdloop = 5
endif
if !exists("g:vake_vakefile")
    let g:vake_vakefile = 'Vakefile'
endif
if !exists("g:vake_vakefiledir")
    let g:vake_vakefiledir = $HOME.'/.vake/'
endif

if !isdirectory(g:vake_vakefiledir)
    call mkdir(g:vake_vakefiledir)
    call system('cp '.g:vake_templatedir.'* '.g:vake_vakefiledir)
endif

command! Vake call vake#Vake()
command! VakeEdit call vake#Edit()
command! VakeCreate call vake#Create()
command! VakeTemplate call vake#Template()

" auto make
function! s:SetAutoCmd(files)
    if type(a:files) != 3
        let file = [a:files]
    else
        let file = a:files
    endif

    if file != []
        for e in file
            exec 'au BufWritePost *.'.e.' call vake#Vake()'
        endfor
    endif

    unlet file
endfunction
au VimEnter * call s:SetAutoCmd(g:vake_autofile)

let &cpo = s:save_cpo
