#!/bin/bash

# TODO: Use more general shebang.
# TODO: Use bash strict mode.

# Define config variables.
# IDEA: Add support for `.issuesrc` config file.
LABELS='TODO|FIXME|BUG|NOTE|XXX|HACK|FEATURE|IDEA'
HEADING="Issues"
OUTFILE="Issues.md"
TMPFILE="issues.tmp"
TMPIGNOREFILE=".issuesignore.tmp"

# Get the root path of the repository.
ROOT=$(git rev-parse --show-toplevel)

# Redirect stdout to the output file.
exec 1>"$ROOT/$OUTFILE"

# Define the regex source and replace patterns.
# IDEA: Add support for `--ignore-issue` comments for lines to ignore.
ESCAPED_LABELS=$(echo "$LABELS" | sed 's/|/\\|/g')
SOURCE_PATTERN='\([^:]*\):\([0-9]*\):.*\('"$ESCAPED_LABELS"'\): \(.*\)'
REPLACE_PATTERN='- [ ] [\3#L\2](\1#L\2): \4'

# Remove comments from the .issueignore file and save it in a tmp file. 
grep "^[^#]" "$ROOT/.issuesignore" > "$ROOT/$TMPIGNOREFILE"

# Write the heading.
echo '# '"$HEADING"
echo ""

# Loop over all files tracked in the repository that are not ignored.
for file in $(git ls-files | grep -v -E -f "$ROOT/$TMPIGNOREFILE")
do
    # Extract all lines of the current file, that have one of the defined issue labels.
    git grep -n -E '('"$LABELS"'): ' -- $ROOT/$file > "$ROOT/$TMPFILE"

    # Continue with the next file, if no lines where extracted.
    if [[ ! -s "$ROOT/$TMPFILE" ]]
    then
        continue
    fi
    
    # Write the subheading for the current file.
    echo "## [$file]($file)"
    echo ""

    # Transform and write the raw lines in Markdown.
    cat "$ROOT/$TMPFILE" | sed 's/'"$SOURCE_PATTERN"'/'"$REPLACE_PATTERN"'/'
    
    # Write a newline as a spacer for the next section.
    echo ""
done

# Clean-up the tmp files.
rm -f "$ROOT/$TMPFILE" "$ROOT/$TMPIGNOREFILE"

