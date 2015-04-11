# rkhunter

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with rkhunter](#setup)
    * [What rkhunter affects](#what-rkhunter-affects)
    * [Beginning with rkhunter](#beginning-with-rkhunter)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

The rkhunter module enables management and configuration of the Unix-based tool, rkhunter, with puppet.

## Module Description

RKHunter (Rootkit Hunter) is a Unix-based tool that scans for rootkits, backdoors and possible local exploits. The rkhunter module allows you to manage the installation of the rkhunter pakage, configuration of how the tool is used, and manages automated usage of the tool.

## Setup

### What rkhunter affects

* Package files for rkhunter.
* Configuration files for rkhunter.


### Beginning with rkhunter

To get a basic setup of the rkhunter tool all you need is:

    include '::rkhunter'

This will get you a basic installation of the rkhunter package with default values.

## Usage

### Configuring RKHunter to not complain about its own configuration.

When the rkhunter tool's configuration differs from what your package manager specifies it should be it will be reported as an error.  One way to prevent this would be to specify the main configuration file to the `pkgmgr_no_vrfy` when declaring the resource:

    class { 'rkhunter':
      pkgmgr_no_vrfy => ['/etc/rkhunter.conf'],
    }

### Updating RKHunter when puppet updates a managed resource.

RKHunter will complain if puppet updates a file, directory, or package without updating its database.  The `rkhunter::propupd` type is used to manage this.  For instance, if you have puppet managing the `sudo` package you can update rkhunter whenever the package updates:

    package { 'sudo':
      ensure => latest,
    }
    
    rkhunter::propupd { 'sudo':
      packages  => 'sudo',
      subscribe => Package['sudo'],
    }

## Reference

### Class: rkhunter

#### rotate_mirrors

Type: bool

#### update_mirrors

Type: bool

#### mirrors_mode

Type: string

Valid values:

* `'any'`
* `'local'`
* `'remote'`

#### mail_on_warning

Type: array

#### `mail_cmd`

Type: string

#### `tmpdir`

Type: string

#### `dbdir`

Type: string

#### `scriptdir`

Type: string

#### `bindir`

Type: array

#### `language`

Type: string

#### `update_lang`

Type: array

#### `logfile`

Type: string

#### `append_log`

Type: bool

#### `copy_log_on_error`

Type: bool

#### `use_syslog`

Type: string

#### `color_set2`

Type: bool

#### `auto_x_detect`

Type: bool

#### `whitelisted_is_white`

Type: bool

#### `allow_ssh_root_user`

Type: string

Valid values:

* `'yes'`
* `'without-password'`
* `'forced-commands-only'`
* `'no'`

#### `allow_ssh_prot_v1`

Type: String

Valid values:

* `'0'`
* `'1'`
* `'2'`

#### `ssh_config_dir`

Type: string

#### `enable_tests`

Type: array

#### `disable_tests`

Type: array

#### `hash_func`

Type: string

#### `hash_fld_idx`

Type: string of digits

#### `pkgmgr`

Type: string

Valid values:

* `''`, and empty sting
* `'NONE'`
* `'RPM'`
* `'DPKG'`
* `'BSD'`
* `'SOLARIS'`

#### `pkgmgr_no_vrfy`

Type: array

#### `ignore_prelink_dep_err`

Type: array

#### `use_sunsum`

Type: bool

#### `user_fileprop_files_dirs`

Type: array

#### `existwhitelist`

Type: array

#### `attrwhitelist`

Type: array

#### `writewhitelist`

Type: array

#### `scriptwhitelist`

Type: array

#### `immutwhitelist`

Type: array

#### `immutable_set`

Type: bool

#### `allowhiddendir`

Type: array

#### `allowhiddenfile`

Type: array

#### `allowprocdelfile`

Type: array

#### `allowproclisten`

Type: array

#### `allowpromiscif`

Type: array

#### `scan_mode_dev`

Type: string

Valid values:

* `''`, an empty string
* `'THOROUGH'`
* `'LAZY'`

#### `phalanx2_dirtest`

Type: bool

#### `allowdevfile`

Type: array

#### `inetd_conf_path`

Type: string

#### `inetd_allowed_svc`

Type: array

#### `xinetd_conf_path`

Type: string

#### `xinetd_allowed_svc`

Type: array

#### `startup_paths`

Type: array

#### `password_file`

Type: string

#### `uid0_accounts`

Type: array

#### `pwdless_accounts`

Type: array

#### `syslog_config_file`

Type: array

#### `allow_syslog_remote_logging`

Type: bool

#### `app_whitelist`

Type: array

#### `suspscan_dirs`

Type: array

#### `suspscan_temp`

Type: string

#### `suspscan_maxsize`

Type: string of digits

#### `suspscan_thresh`

Type: string of digits

#### `port_whitelist`

Type: array

#### `os_version_file`

Type: string

#### `rtkt_dir_whitelist`

Type: array

#### `rtkt_file_whitelist`

Type: array

#### `shared_lib_whitelist`

Type: array

#### `stat_cmd`

Type: string

#### `readlink_cmd`

Type: string

#### `epoch_date_cmd`

Type: string

#### `modules_dir`

Type: string

#### `web_cmd`

Type: string

#### `warn_on_os_change`

Type: bool

#### `updt_on_os_change`

Type: bool

#### `use_locking`

Type: bool

#### `lock_timeout`

Type: string of digits

#### `show_lock_msgs`

Type: bool

#### `scanrootkitmode`

Type: bool

#### `unhide_tests`

Type: array

#### `disable_unhide`

Type: string

Valid values:

* `'0'`
* `'1'`
* `'2'`

#### `installdir`

Type: string

### Resource: rkhunter::propupd

#### files
  String or list of files to have rkhunter update its stored hash for.  If a string is used it is expected to be a single files or a space serperated list of files.

#### directories
  String or list of directories to have rkhunter update its stored hash for.  If a string is used it is expected to be a single directory or a space serperated list of directories.

#### packages
  String or list of packages to have rkhunter update its stored hash for.  If a string is used it is expected to be a single package or a space serperated list of packages.

## Limitations

Currently rkhunter is only actively tested with the following operating systems:

* Debian 7.x
* CentOS 6.x
* Ubuntu 14.04
