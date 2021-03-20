# Issues

*Collect all issue comments (e.g. `TODO`, `FIXME`, ...) in one file.*

## Usage

Copy the script [`issues.sh`](issues.sh) to your git repository, for example via:

```bash
wget https://raw.githubusercontent.com/DavidHeresy/git-issues/main/issues.sh
```

Generate the [ISSUES.md](ISSUES.md) file with:

```bash
bash issues.sh
```

You can also set an alias like:

```bash
alias issues="bash issues.sh"
```

### Ignore Some Files

You can specify which files to ignore in the [.issuesignore](.issuesignore) file.
Is supports comments starting with `#` and 
[POSIX extended regex patterns](https://en.wikipedia.org/wiki/Regular_expression#POSIX_extended).

### TODO: Use as Git Hook

### TODO: Setup as Git Alias

## Development

Run `source workspace` to enter the development environment.

## Roadmap

- TODO: Generate `Issues.md` with a GitHub Job.
- TODO: Test `issues.sh` with big public projects.
- IDEA: Make `issues.sh` work for projects, that aren't a git repository.

