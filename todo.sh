#!/bin/bash

# Get the root path of the repository.
ROOT=$(git rev-parse --show-toplevel)

# Redirect stdout to TODO.md.
exec 1>"$ROOT/TODO.md"

# Write the heading.
echo "# TODO"
echo ""

# Loop over all files tracked in the repository.
for file in $(git ls-files)
do
    # Save all TODOs of the current file in todo.tmp.
    git grep -n "TODO: " $ROOT/$file > "$ROOT/todo.tmp"
    
    # Check if there were any TODOs.
    if [[ -s "$ROOT/todo.tmp" ]]
    then

        # Write the subheading for the current file.
        echo "## [$file]($file)"
        echo ""

        # Transform the TODOs from todo.tmp into a list with a checkboxes
        # and links to the linenumber in the original code file. 
        cat "$ROOT/todo.tmp" \
            | sed 's/\([^:]*\):\([0-9]*\):.*TODO: \(.*\)/- [ ] [\3](\1#L\2)/'
        
        # Write a newline as a spacer for the next section.
        echo ""
    fi
done

# Clean-up the todo.tmp file.
rm -f "$ROOT/todo.tmp"

