%global debug_package %{nil}

Name:           sczip
Version:        1.0.0
Release:        1%{?dist}
Summary:        Simple directory backup utility with gitignore-style exclusions

License:        MIT
URL:            https://github.com/ConradoJC/sczip
Source0:        %{name}-%{version}.tar.gz

Requires:       bash
Requires:       rsync
Requires:       zip

%description
SCZip creates ZIP backups of the current directory. It reads a .scignore
file using gitignore-style exclusion patterns and shows the selected
file count and total size before creating the archive.

SCZip does not require a Git repository and does not require Git at runtime.

%prep
%setup -q

%build
# Nothing to build.

%install
install -D -m 0755 sczip %{buildroot}%{_bindir}/sczip

%files
%{_bindir}/sczip

%changelog
* Mon Sep 28 2026 Conrado <conrado0804@gmail.com> - 1.0.0-1
- Initial release.
