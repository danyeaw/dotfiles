# Shell command rules

1. One command per bash call. Never use `;`, `|`, `&`, `&&`, `>`, `>>`, `$(...)`, backticks, or multi-line commands — they are hard-denied.
2. To run several commands, issue multiple bash tool calls in a single message (parallel), each with one simple command.
3. Prefer dedicated tools over shell: read/glob/grep for file inspection, edit/write for file changes. Use bash only for git, gh, package managers, tests, and linters.
4. In PowerShell, use cmdlet flags instead of formatting pipelines: `Get-ChildItem -Name`, `Get-ChildItem -Recurse -Filter`, never `| Select-Object` / `| Where-Object` / `| Format-Table`.
5. Expect `ask` prompts (not errors) for mutating commands: `git commit/push/reset/rebase/clean`, `conda install/create/remove/update`, `pip install`, `gh pr create`. Do not retry them with different syntax; let the user approve.
6. Allowed without prompting as single commands: `git log/show/diff/status/blame/...`, `gh issue/pr/run/repo` read-only subcommands, `rg`, `pytest`, `ruff`, `mypy`, `python`, `Get-ChildItem`, `Get-Content`, `Test-Path`.
