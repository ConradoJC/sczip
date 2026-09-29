# SCZip

SCZip is a simple Linux directory backup utility.

It creates a ZIP archive of the directory from which it is executed and uses a `.scignore` file to exclude files and directories.

The `.scignore` syntax is inspired by common `.gitignore` patterns.

## Usage

From any directory:

```
sczip
```

SCZip reads:

```
./.scignore
```

and creates an archive similar to:

```
backup_my-project_2026-09-28_14-30-00.zip
```

The generated ZIP and the `.scignore` file are automatically excluded from the backup.

Before creating the archive, SCZip displays the number of files and the total size of the content that will be compressed and asks for confirmation.

## .scignore

Example:

```
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
```

### Common patterns

Ignore a directory:

```
node_modules/
```

Ignore files with an extension:

```
*.log
```

Ignore a specific path relative to the project root:

```
/config.local
/private/
```

Ignore environment files:

```
.env
.env.*
```

Re-include a previously ignored path:

```
!important.txt
```

Comments start with `#`.

Blank lines are ignored.

SCZip supports common exclusion patterns, but `.scignore` is not intended to provide every advanced feature of Git's `.gitignore` implementation.

## No Git required

SCZip does not need a Git repository and does not call Git.

The `.scignore` file is simply interpreted by SCZip.

You can use SCZip in any directory, regardless of whether it is a Git repository.

## Installation

### Fedora / RPM

Install the RPM directly from the GitHub Release:

```
sudo dnf install https://github.com/ConradoJC/sczip/releases/download/v1.0.0/sczip-1.0.0-1.fc44.x86_64.rpm
```

Or download the RPM and install it locally:

```
sudo dnf install ./sczip-1.0.0-1.fc44.x86_64.rpm
```

The RPM declares the following runtime dependencies:

* bash
* rsync
* zip

DNF will resolve these dependencies automatically.

### Debian / Ubuntu / DEB

Download the DEB from the GitHub Release:

```
wget -O /tmp/sczip_1.0.0_amd64.deb https://github.com/ConradoJC/sczip/releases/download/v1.0.0/sczip_1.0.0_amd64.deb
```

Then install it:

```
sudo apt install /tmp/sczip_1.0.0_amd64.deb
```

Or, if the package has already been downloaded:

```
sudo apt install ./sczip_1.0.0_amd64.deb
```

The DEB declares the following runtime dependencies:

* bash
* rsync
* zip

APT will resolve these dependencies automatically.

## Development

The source tree is intentionally small:

```
sczip/
├── sczip
├── sczip.spec
├── README.md
├── LICENSE
├── build-rpm.sh
├── build-deb.sh
├── test.sh
├── .gitignore
└── .scignore.example
```

### Build RPM

On Fedora:

```
./build-rpm.sh
```

The RPM is generated under:

```
~/rpmbuild/RPMS/
```

### Build DEB

On Debian/Ubuntu:

```
./build-deb.sh
```

The DEB is generated in the project directory:

```
sczip_1.0.0_amd64.deb
```

### Run tests

The test suite can be executed with:

```
./test.sh
```

The tests verify `.scignore` behavior, excluded directories, re-included files, ZIP creation, and other basic backup behavior.

## Release

The official releases are published on GitHub:

https://github.com/ConradoJC/sczip/releases

The `v1.0.0` release provides packages for:

* Fedora and other RPM-based distributions: `.rpm`
* Debian, Ubuntu and other DEB-based distributions: `.deb`

## License

SCZip is released under the MIT License.
