if exists('g:clipboard_override_loaded')
  finish
endif
let g:clipboard_override_loaded = 1

if !exists("g:clipboard_override_yank")
  let g:clipboard_override_yank = {}
endif
if !exists("g:clipboard_override_paste")
  let g:clipboard_override_paste = {}
endif

function! s:yank()
  if has_key(g:clipboard_override_yank, v:register)
    let cmd = g:clipboard_override_yank[v:register]
    call system(cmd, getreg(v:register))
    if v:shell_error != 0
      echoerr printf("Yank command failed for clipboard '%s': %s", v:register, cmd)
    endif
  endif
endfunction

function! s:paste(char)
  if has_key(g:clipboard_override_paste, v:register)
    let cmd = g:clipboard_override_paste[v:register]
    call setreg(v:register, system(cmd))
    if v:shell_error != 0
      echoerr printf("Paste command failed for clipboard '%s': %s", v:register, cmd)
      return ""
    endif
  endif
  return a:char
endfunction

autocmd TextYankPost * call <SID>yank()

nnoremap <expr> p <SID>paste("p")
nnoremap <expr> P <SID>paste("P")
vnoremap <expr> p <SID>paste("p")
