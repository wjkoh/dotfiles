let &l:makeprg = 'hg fixwdir --whole % && '
let &l:makeprg = &l:makeprg . 'hg lint --working-dir --whole --config google.lint.template.finding="{relpath(path)}:{line}: {text}\n" %'
let &l:errorformat = '%f:%l: %m'

if &filetype == 'python'
  let &l:makeprg = '/google/bin/releases/python-team/public/importorder --reformat_imports --inplace % && ' . &l:makeprg
endif
