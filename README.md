# Status Report

*Generate a status report from your "TODO:" comments.*

## Usage

Copy the script [`status-report.sh`](status-report.sh) to your
git repository. Generate the [StatusReport.md](StatusReport.md) file with:

```bash
bash status-report.sh
```

You can also set an alias like:

```bash
alias sr="bash status-report.sh"
```

## Development

Run `source workspace` to enter the development environment.

## TODOs

- TODO: Use strict mode and default system shell.
- TODO: Add README section how to add todo.sh as post-commit hook.
- FEATURE: Add support for `<file>#L<linenumber>` entries in `.todoignore`.
- FEATURE: Add support for `NOTE`, `XXX`, `HACK`, `FIXME`, `BUG` tags.
- FEATURE: Add support for `.todorc` file with custom search patterns.

