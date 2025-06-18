#!/bin/sh
set -e
PATH="/usr/local/bin:$PATH"
dir="$HOME/.tags"
trap 'rm -f "$dir/$$.tags"' EXIT
ctags -R --tag-relative=always --fields=+l --languages=python --python-kinds=-iv -f"$dir/$$.tags" $(python3 -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))") 
mv "$dir/$$.tags" "$dir/tags"
