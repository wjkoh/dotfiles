" Sort Python imports and remove unused imports using pyfactor. See
" go/pyfactor-fix-imports for details.
let &l:makeprg = '/google/data/ro/teams/youtube-code-health/pyfactor fix_imports --remove_unused && '
let &l:makeprg = &l:makeprg . 'hg fix && '
let &l:makeprg = &l:makeprg . 'build_cleaner --blaze_output_base=/tmp/build_cleaner && '
let &l:makeprg = &l:makeprg . 'tricorder analyze -fast -fix && '
let &l:makeprg = &l:makeprg . 'hg lint --working-dir --rev tree --config google.lint.template.finding="{relpath(path)}:{line}: {text}\n"'
let &l:errorformat = '%f:%l: %m'
