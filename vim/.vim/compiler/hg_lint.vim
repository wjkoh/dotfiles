let &l:makeprg = 'hg fixwdir --whole % && '
let &l:makeprg = &l:makeprg . 'hg lint --working-dir --whole --config google.lint.template.finding="{relpath(path)}:{line}: {text}\n" %'
let &l:errorformat = '%f:%l: %m'

if &filetype == 'python'
  " Sort Python imports and remove unused imports using pyfactor. See
  " go/pyfactor-fix-imports for details.
  let &l:makeprg = '/google/data/ro/teams/youtube-code-health/pyfactor fix_imports --remove_unused % && ' . &l:makeprg
  " Sort Python imports using importorder.py.
  " let &l:makeprg = '/google/bin/releases/python-team/public/importorder --reformat_imports --inplace % && ' . &l:makeprg
endif
