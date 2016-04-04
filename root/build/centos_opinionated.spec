%define __jar_repack %{nil}
%define __os_install_post %{nil}
%define debug_package %{nil}

Name: centos_opinionated
Summary: fake rpm to avoid some files to be overriden by centos system packages
Version: 1.0.0
Release: 1
License: MIT
Group: System Environment/Base
URL: https://github.com/thefab/docker-centos-opinionated
Buildroot: %{_topdir}/tmp/%{name}-root
Packager: Fabien MARTY <fabien.marty@gmail.com>
ExclusiveOs: linux
AutoReq: no
Provides: syslog, rsyslog-gnutls, rsyslog-gssapi, rsyslog-mysql, rsyslog-pgsql, rsyslog-relp, rsyslog-snmp, rsyslog7-elasticsearch, rsyslog7-gnutls, rsyslog7-gssapi, rsyslog7-mysql, rsyslog7-pgsql, rsyslog7-relp, rsyslog7-snmp, rsyslog, rsyslog7, /etc/rsyslog.d

%description
This package is a fake one just to avoid some files to be overriden by
some centos (standard) system packages (like rsyslog and cron).

%prep

%pre

%build

%install
mkdir -p %{buildroot} 2>/dev/null
echo foo >/dev/null

%post

%postun

%clean
rm -fr %{buildroot}

%files
%defattr(-,root,root)
