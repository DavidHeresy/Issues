#!/usr/bin/env bash

# Use bash strict mode.
set -Eeuo pipefail

# Define config variables.
# IDEA: Add support for `.issuesrc` config file.
LABELS='TODO|FIXME|BUG|NOTE|XXX|HACK|FEATURE|IDEA|WISH'
HEADING="Issues"
OUTFILE="ISSUES.md"
TMPFILE=".issues.tmp"
TMPIGNOREFILE=".issuesignore.tmp"

# Get the root path of the repository.
ROOT=$(git rev-parse --show-toplevel)

# Redirect stdout to the output file.
exec 1>"$ROOT/$OUTFILE"

# Define the regex source and replace patterns.
# IDEA: Add support for `--ignore-issue` comments for lines to ignore.
ESCAPED_LABELS=$(echo "$LABELS" | sed 's/|/\\|/g')
SOURCE_PATTERN='HEAD:\([^:]*\):\([0-9]*\):.*\('"$ESCAPED_LABELS"'\): \(.*\)'
REPLACE_PATTERN='- [ ] [\3#L\2](\1#L\2): \4'

# Save .issueignore if exists.
if [[ -f "$ROOT/.issuesignore" ]]
then
    # Remove comments from the .issueignore file and save it in a tmp file. 
    grep "^[^#]" "$ROOT/.issuesignore" > "$ROOT/$TMPIGNOREFILE"
else
    echo "" > "$ROOT/$TMPIGNOREFILE"
fi

# Write the heading.
echo '# '"$HEADING"
echo ""

# Loop over all files tracked in the repository that are not ignored.
for file in $(git ls-files | grep -v -E -f "$ROOT/$TMPIGNOREFILE")
do
    # Extract all lines of the file at HEAD, that have one of the defined issue labels.
    git grep -n -E '('"$LABELS"'): ' "HEAD" -- "$ROOT/$file" > "$ROOT/$TMP_ISSUES" || true

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

# Commit the update.
git add $OUTFILE
git commit -m "Update $OUTFILE" > /dev/null 2>&1

