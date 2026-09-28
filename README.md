# sczip

sczip is a simple Linux directory backup utility.

It creates a ZIP archive of the directory from which it is executed and
uses a .scignore file to exclude files and directories.

The .scignore syntax is designed to be compatible with common
.gitignore patterns.

## Usage

From any directory:

    sczip

SCZip reads:

    ./.scignore

and creates an archive similar to:

    backup_my-project_2026-09-28_14-30-00.zip

The generated ZIP is automatically excluded from the backup.

## .scignore

Example:

    # Dependencies
    node_modules/

    # Git
    .git/

    # Environment files
    .env
    .env.*

    # Logs
    *.log

    # Build output
    dist/
    build/

    # Local uploads
    uploads/

    # Temporary files
    *.tmp
    *.temp

    # Re-include one file
    !uploads/important.txt

### Common patterns

Ignore a directory:

    node_modules/

Ignore files with an extension:

    *.log

Ignore a specific path relative to the project root:

    /config.local
    /private/

Ignore all .env variants:

    .env*

Re-include a previously ignored path:

    !important.txt

Comments start with #.

Blank lines are ignored.

## No Git required

SCZip does not need a Git repository and does not call Git.

The .scignore file is simply a file interpreted by SCZip.

## Installation

When packaged as an RPM:

    sudo dnf install sczip-1.0.0-1.fc44.x86_64.rpm

Direct Install:
    sudo dnf install https://github.com/ConradoJC/sczip/releases/download/v1.0.0/sczip-1.0.0-1.fc44.x86_64.rpm

The RPM declares rsync and zip as dependencies, so DNF installs them automatically.

## Development

The source tree is intentionally small:

    sczip/
    ├── sczip
    ├── sczip.spec
    ├── README.md
    ├── LICENSE
    ├── .gitignore
    └── .scignore.example

## License

SCZip is released under the MIT License.
