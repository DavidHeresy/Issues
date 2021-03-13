# Git Issues

*Collect all issue comments (e.g. `TODO`, `FIXME`, ...) in one file.*

## Usage

Copy the script [`issues.sh`](issues.sh) to your git repository.
Generate the [Issues.md](Issues.md) file with:

```bash
bash issues.sh
```

You can also set an alias like:

```bash
alias issues="bash issues.sh"
```

## Development

Run `source workspace` to enter the development environment.

## Roadmap

- TODO: Use strict mode.
- TODO: Add README section how to use `issues.sh` as a git hook.
- FETURRE: Add support for `--ignore-issue` comments for lines to ignore.
- FEATURE: Add support for `.issuesconfig` file with custom config variables.
- FEATURE: Make `issues` work for projects, that aren't a git repository.
- FEATURE: Make `issues` work as a system-wide script / program.

