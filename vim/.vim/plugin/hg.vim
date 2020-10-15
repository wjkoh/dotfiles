" https://vim.fandom.com/wiki/Diff_current_buffer_and_the_original_file
function! s:ReadOutputToScratch(command, filetype)
  let filetype = !empty(a:filetype) ? a:filetype : &l:filetype
  vert new
  execute 'read !' a:command
  " Delete the blank line at the beginning.
  normal! 1Gdd
  let &l:filetype = filetype
  setlocal buftype=nofile bufhidden=wipe nobuflisted readonly noswapfile
endfunction

"  # is replaced with the filename of the original buffer you're editing.
command! HgAnnotate call s:ReadOutputToScratch('hg annotate --user --number #', '')
command! HgChild call s:ReadOutputToScratch('hg cat --rev .~-1 #', '')
command! HgDiffAll call s:ReadOutputToScratch('hg diff --rev .^', 'diff')
command! HgDiffThis call s:ReadOutputToScratch('hg diff --rev .^ #', 'diff')
command! HgParent call s:ReadOutputToScratch('hg cat --rev .^ #', '')
command! HgDiffWorkingDir call s:ReadOutputToScratch('hg diff --rev .', 'diff')
