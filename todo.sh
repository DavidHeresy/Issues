#!/bin/bash

# Get the root path of the repository.
ROOT=$(git rev-parse --show-toplevel)

# Redirect stdout to TODO.md.
exec 1>"$ROOT/TODO.md"

# Define the TODO comment pattern and Markdown replace string for sed.
PATTERN='\([^:]*\):\([0-9]*\):.*TODO: \(.*\)'
REPLACE='- [ ] [L#\2](\1#L\2): \3'

# Write the heading.
echo "# TODO"
echo ""

# Loop over all files tracked in the repository.
for file in $(git ls-files)
do
    # Skip the current file, if it is contained in the .todoignore.
    if [[ ! -z $(git grep "$file" "$ROOT/.todoignore") ]]
    then
        continue
    fi

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
        cat "$ROOT/todo.tmp" | sed 's/'"$PATTERN"'/'"$REPLACE"'/'
        
        # Write a newline as a spacer for the next section.
        echo ""
    fi
done

# Clean-up the todo.tmp file.
rm -f "$ROOT/todo.tmp"

