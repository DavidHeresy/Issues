#!/bin/bash

# Define config variables.
REPORT="StatusReport.md"
TAGS='TODO|FIXME|BUG|NOTE|XXX|HACK|FEATURE|IDEA'
HEADING="Status Report"
TMP_FILE="StatusReport.tmp"

# Get the root path of the repository.
ROOT=$(git rev-parse --show-toplevel)

# Redirect stdout to the report file.
exec 1>"$ROOT/$REPORT"

# Define the supported tags, search pattern and Markdown replace string.
ESCAPED_TAGS=$(echo "$TAGS" | sed 's/|/\\|/g')
SOURCE_PATTERN='\([^:]*\):\([0-9]*\):.*\('"$ESCAPED_TAGS"'\): \(.*\)'
TARGET_PATTERN='- [ ] [\3#L\2](\1#L\2): \4'

# Write the heading.
echo '# '"$HEADING"
echo ""

# Loop over all files tracked in the repository.
for file in $(git ls-files)
do
    # Skip the current file, if it is listed to be ignored.
    if [[ ! -z $(git grep "$file" "$ROOT/.srignore") ]]
    then
        continue
    fi

    # Extract all lines of the current file, that have one of the defined tags.
    git grep -n -E '('"$TAGS"'): ' -- $ROOT/$file > "$ROOT/$TMP_FILE"

    # Continue with the next file, if no lines where extracted.
    if [[ ! -s "$ROOT/$TMP_FILE" ]]
    then
        continue
    fi
    
    # Write the subheading for the current file.
    echo "## [$file]($file)"
    echo ""

    # Transform and write the raw lines in Markdown.
    cat "$ROOT/$TMP_FILE" | sed 's/'"$SOURCE_PATTERN"'/'"$TARGET_PATTERN"'/'
    
    # Write a newline as a spacer for the next section.
    echo ""
done

# Clean-up the tmp file.
rm -f "$ROOT/$TMP_FILE"

