# TODO

## [README.md](README.md)

README.md:11:- TODO: Add README section how to add todo.sh as post-commit hook.
README.md:12:- TODO: Add support for `NOTE`, `XXX`, `HACK`, `FIXME`, `BUG` tags.
README.md:13:- TODO: Add support for `.todoignore` file.
README.md:14:- TODO: Add support for `.todorc` file with custom search patterns.

## [todo.sh](todo.sh)

todo.sh:17:    git grep -n "TODO: " $ROOT/$file > "$ROOT/todo.tmp"
todo.sh:30:            | sed 's/\([^:]*\):\([0-9]*\):TODO: \(.*\)/- [ ] [\3](\1#L\2)/'

