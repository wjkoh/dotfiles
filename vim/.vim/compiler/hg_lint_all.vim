let &l:makeprg = 'hg fix && '
let &l:makeprg = &l:makeprg . 'hg lint --config google.lint.template.finding="{relpath(path)}:{line}: {text}\n"'
let &l:errorformat = '%f:%l: %m'
