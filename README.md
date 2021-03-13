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

## Roadmap

- TODO: Use strict mode.
- TODO: Add README section how to use `status-report.sh` as a git hook.
- FETURRE: Add support for `--srignore` comments for lines to ignore.
- FEATURE: Add support for `.srconfig` file with custom config variables.
- FEATURE: Make `sr` work for projects, that aren't a git repository.
- FEATURE: Make `sr` work as a system-wide script / program.

