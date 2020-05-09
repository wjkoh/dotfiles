let &l:makeprg = 'hg fixwdir && '
let &l:makeprg = &l:makeprg . 'hg lint --working-dir --config google.lint.template.finding="{relpath(path)}:{line}: {text}n"'
let &l:errorformat = '%f:%l: %m'
