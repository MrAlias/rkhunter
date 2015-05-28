# rkhunter

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What rkhunter affects](#what-rkhunter-affects)
    * [Beginning with rkhunter](#beginning-with-rkhunter)
4. [Usage](#usage)
    * [Configuring RKHunter to not complain about its own configuration](#configuring-rkhunter-to-not-complain-about-its-own-configuration)
    * [Updating RKHunter when puppet updates a managed resource](#updating-rkhunter-when-puppet-updates-a-managed-resource)
    * [Updating RKHunter when files are changed](#updating-rkhunter-when-files-are-changed)
5. [Reference](#reference)
    * [Class: rkhunter](#class-rkhunter)
    * [Resource: rkhunter::propupd](#resource-rkhunterpropupd)
6. [Limitations](#limitations)

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

### Configuring RKHunter to not complain about its own configuration

When the rkhunter tool's configuration differs from what your package manager specifies it should be it will be reported as an error.  One way to prevent this would be to specify the main configuration file to the `pkgmgr_no_vrfy` when declaring the resource:

    class { 'rkhunter':
      pkgmgr_no_vrfy => ['/etc/rkhunter.conf'],
    }

### Updating RKHunter when puppet updates a managed resource

RKHunter will complain if puppet updates a file, directory, or package without updating its database.  The `rkhunter::propupd` type is used to manage this.  For instance, if you have puppet managing the `sudo` package you can update rkhunter whenever the package updates:

    package { 'sudo':
      ensure => latest,
    }
    
    rkhunter::propupd { 'sudo':
      packages  => 'sudo',
      subscribe => Package['sudo'],
    }

### Updating RKHunter when files are changed

RKHunter will complain if files in its database are changed. If you have puppet update one of these sensitive files the `rkhunter::propupd` type can also be used to update RKHunter appropriately.

For instance update the rkhunter database after modifying multiple PostgreSQL configuration files:

    rkhunter::propupd { 'postgresql configs':
      file      => [
        '/etc/postgresql/9.1/main/pg_hba.conf',
        '/etc/postgresql/9.1/main/pg_ident.conf',
        '/etc/postgresql/9.1/main/postgresql.conf',
      ],
      subscribe => [
        File['/etc/postgresql/9.1/main/pg_hba.conf'],
        File['/etc/postgresql/9.1/main/pg_ident.conf'],
        File['/etc/postgresql/9.1/main/postgresql.conf'],
      ],
    }

Another possibility to update the PostgreSQL configuration files would be to just update the entire directory.

    rkhunter::propupd { 'postgresql configs':
      directory => '/etc/postgresql/9.1/main/',
      subscribe => [
        File['/etc/postgresql/9.1/main/pg_hba.conf'],
        File['/etc/postgresql/9.1/main/pg_ident.conf'],
        File['/etc/postgresql/9.1/main/postgresql.conf'],
      ],
    }

## Reference

### Class: rkhunter

#### `rotate_mirrors`

If this option is set to `true`, it specifies that the mirrors file ('mirrors.dat'), which is used when the '--update' and '--versioncheck' options are used, is to be rotated. Rotating the entries in the file allows a basic form of load-balancing between the mirror sites whenever the above options are used.

If the option is set to `false`, then the mirrors will be treated as if in a priority list. That is, the first mirror listed will always be used first.  The second mirror will only be used if the first mirror fails, the third mirror will only be used if the second mirror fails, and so on.

If the mirrors file is read-only, then the '--versioncheck' command-line option can only be used if this option is set to `false`.

**Type**: `bool`

**Default value**: `true`

#### `update_mirrors`

If this option is set to `true`, it specifies that when the '--update' option is used, then the mirrors file is to be checked for updates as well. If the current mirrors file contains any local mirrors, these will be prepended to the updated file. If this option is set to `false`, the mirrors file can only be updated manually. This may be useful if only using local mirrors.

**Type**: `bool`

**Default value**: `true`

#### `mirrors_mode`

Tells rkhunter which mirrors are to be used when the '--update' or '--versioncheck' command-line options are given.

**Type**: `string`

**Default value**: `any`

**Valid values**:

* `'any'`
* `'local'`
* `'remote'`

#### `mail_on_warning`

Email a message to these addresses if a warning is found when the system is being checked.

**Type**: `array`

**Default value**: `[]`

#### `mail_cmd`

Specifies the mail command to use if `mail_on_warning` is set.

**Type**: `string`

**Default value**: `"main -s \"[rkhunter] Warnings found for ${hostname}\""`

#### `tmpdir`

Specifies the directory to use for temporary files.

**_NOTE_**: Do not use '/tmp' as your temporary directory. Some important files will be written to this directory, so be sure that the directory permissions are secure.

**Type**: `string`

#### `dbdir`

Specifies the database directory to use.

**Type**: `string`

**Default value**: `'/var/lib/rkhunter/db'`

#### `scriptdir`

Specifies the script directory to use.

**Type**: `string`

**Default value**: `'/var/local/lib/rkhunter/scripts'`

#### `bindir`

Modify the command directory list used by rkhunter to locate commands (that is, its PATH). By default this will be the root PATH, and an internal list of some common command directories.

Any directories specified here will, by default, be appended to the default list. However, if a directory name begins with the '+' character, then that directory will be prepended to the list (that is, it will be put at the start of the list).

**Type**: `array`

**Default value**: `[]`

#### `language`

Specifies the default language to use. This should be similar to the ISO 639 language code.

**_NOTE_**: Please ensure that the language you specify is supported.  For a list of supported languages use the following command:

     rkhunter --lang en --list languages

**Type**: `string`

**Default value**: `'en'`

#### `update_lang`

List of the languages that are to be updated when the '--update' option is used. If unset, then all the languages will be updated. If none of the languages are to be updated, then set this option to just 'en'.

The default language, specified by the LANGUAGE option, and the English (en) language file will always be updated regardless of this option.

**Type**: `array`

**Default value**: `[]`

#### `logfile`

Specifies the log file pathname. The file will be created if it does not initially exist. If the option is unset, then the program will display a message each time it is run saying that the default value is being used.

**Type**: `string`

**Default value**: `'/var/log/rkhunter.log'`

#### `append_log`

Set to `true` if the log file is to be appended to whenever rkhunter is run. A value of `false` will cause a new log file to be created whenever the program is run.

**Type**: `bool`

**Default value**: `false`

#### `copy_log_on_error`

Set to `true` if the log file is to be copied when rkhunter finishes and an error or warning has occurred. The copied log file name will be appended with the current date and time (in YYYY-MM-DD\_HH:MM:SS format).  For example:

     rkhunter.log.2009-04-21_00:57:51

If the option value is `false`, then the log file will not be copied regardless of whether any errors or warnings occurred.

**Type**: `bool`

**Default value**: `false`

#### `use_syslog`

Set to enable the rkhunter check start and finish times to be logged by syslog. Warning messages will also be logged. The value of the option must be a standard syslog facility and priority, separated by a dot.  For example:

     USE_SYSLOG=authpriv.warning

Setting the value to `'NONE'` or `''` disables the use of syslog.

**Type**: `string`

**Default value**: `''`

#### `color_set2`

Set to `true` if the second colour set is to be used. This can be useful if your screen uses black characters on a white background (for example, a PC instead of a server). A value of `false` will cause the default colour set to be used.

**Type**: `bool`

**Default value**: `false`

#### `auto_x_detect`

Set to `false` if rkhunter should not detect if X is being used. If X is detected as being used, then the second colour set will automatically be used. If set to `true`, then the use of X will be detected.

**Type**: `bool`

**Default value**: `true`

#### `whitelisted_is_white`

Set to `true` if it is wanted that any 'Whitelisted' results are shown in white rather than green. For colour set 2 users, setting this option will cause the result to be shown in black. Setting the option to `false` causes whitelisted results to be displayed in green.

**Type**: `bool`

**Default value**: `false`

#### `allow_ssh_root_user`

This is checked against the SSH configuration file 'PermitRootLogin' option. A warning will be displayed if they do not match.  However, if a value has not been set in the SSH configuration file, then a value here of 'unset' can be used to avoid warning messages.

**Type**: `string`

**Default value**: `no`

**Valid values**:

* `'yes'`
* `'unset'`
* `'without-password'`
* `'forced-commands-only'`
* `'no'`

#### `allow_ssh_prot_v1`

Set to `'1'` to allow the use of the SSH-1 protocol, but note that theoretically it is weaker, and therefore less secure, than the SSH-2 protocol. Do not modify this option unless you have good reasons to use the SSH-1 protocol (for instance for AFS token passing or Kerberos4 authentication).

If the 'Protocol' option has not been set in the SSH configuration file, then a value of `'2'` may be set here in order to suppress a warning message.

A value of `'0'` indicates that the use of SSH-1 is not allowed.

**Type**: `string`

**Default value**: `'0'`

**Valid values**:

* `'0'`
* `'1'`
* `'2'`

#### `ssh_config_dir`

Tells rkhunter the directory containing the SSH configuration file. This setting will be worked out by rkhunter, and so should not usually need to be set.

**Type**: `string`

**Default value**: `''`

#### `enable_tests`

List of tests that are to be performed. If `'all'` is specified all available tests will be performed.

**Type**: `array`

**Default value**: `['all']`

#### `disable_tests`

List of tests that are not to be performed. If `'none'` is specified no tests will be disabled.

**Type**: `array`

**Default value**: `['suspcan', 'hidden_procs', 'deleted_files', 'packet_cap_apps', 'apps']`

#### `hash_func`

Specify the function to use for the file properties hash value check.

It can be specified as just the command name or the full pathname. If just the command name is given, and it is one of MD5, SHA1, SHA224, SHA256, SHA384 or SHA512, then rkhunter will first look for the relevant command, such as 'sha256sum', and then for 'sha256'. If neither of these are found, it will then look to see if a perl module has been installed which will support the relevant hash function.

To see which perl modules have been installed:

     rkhunter --list perl

Systems using prelinking are restricted to using either the SHA1 or MD5 function.

A value of 'NONE' (in uppercase) can be specified to indicate that no hash function should be used. Rkhunter will detect this, and automatically disable the file properties hash check test.

**_NOTE_**: Whenever this option is changed `rkhunter --propupd` must be run.

**Type**: `string`

**Default value**: `''`

#### `hash_fld_idx`

Specifies which field from the `hash_func` command output contains the hash value. The fields are assumed to be space-separated.

**Type**: `integer` greater than zero

**Default value**: `1`

#### `pkgmgr`

Tells rkhunter to use the specified package manager to obtain the file property information. This is used when updating the file properties file ('rkhunter.dat'), and when running the file properties check.

* For RedHat/RPM-based systems, `'RPM'` can be used to get information from the RPM database.
* For Debian-based systems `'DPKG'` can be used.
* For \*BSD systems `'BSD'` can be used.
* For Solaris systems `'SOLARIS'` can be used.
* If set to `''` or a value of `'NONE'`, no package manager is to be used.

The current package managers, except 'SOLARIS', store the file hash values
using an MD5 hash function. The Solaris package manager includes a checksum
value, but this is not used by default (see `use_sunsum` below).

The `'DPKG'` and `'BSD'` package managers only provide MD5 hash values.  The `'RPM'` package manager additionally provides values for the inode, file permissions, uid, gid and other values. The `'SOLARIS'` also provides most of the values, similar to `'RPM'`, but not the inode number.

For any file not part of a package, rkhunter will revert to using the `hash_cmd` hash function instead.

**_NOTE_**: Whenever this option is changed `rkhunter --propupd` must be run.

**Type**: `string`

**Default value**: `''`

**Valid values**:

* `''`, an empty sting
* `'NONE'`
* `'RPM'`
* `'DPKG'`
* `'BSD'`
* `'SOLARIS'`

#### `pkgmgr_no_vrfy`

Specifies a pathname which is to be exempt from the package manager verification process, and which will be treated as a non-packaged file. As such, the file properties are still checked.

This option only takes effect if the `pkgmgr` option has been set, and is not `'NONE'`.

**_NOTE_**: Whenever this option is changed `rkhunter --propupd` must be run.

**Type**: `array`

**Default value**: `[]`

#### `ignore_prelink_dep_err`

List of command pathnames to have rkhunter ignore any prelink dependency errors for. However, a warning will also be issued if the error does not occur for a given command. As such this option must only be used on commands which experience a persistent problem.

**_NOTE_**: Whenever this option is changed `rkhunter --propupd` must be run.

**Type**: `array`

**Default value**: `[]`

#### `use_sunsum`

If the `'SOLARIS'` package manager is used, then it is possible to use the checksum (hash) value stored for a file. However, this is only a 16-bit checksum, and as such is not nearly as secure as, for example, a SHA-2 value.  If this is set to `false`, then the checksum is not used and the hash function given by `hash_func` is used instead. To enable this option, set its value to `true`. The Solaris 'sum' command must be present on the system if this option is used.

**Type**: `bool`

**Default value**: `false`

#### `user_fileprop_files_dirs`

List of user commands, directories, or file pathnames which will be included in the file properties checks.

**_NOTE_**: Only files and directories which have been added by the user, and are not part of the internal lists, can be excluded. So, for example, it is not possible to exclude the 'ps' command by using '/bin/ps'. These will be silently ignored from the configuration.

**_NOTE_**: Whenever this option is changed `rkhunter --propupd` must be run.

**Type**: `array`

**Default value**: `[]`

#### `exclude_user_fileprop_files_dirs`

List of user commands, directories, or file pathnames which will be excluded in the file properties checks.

**_NOTE_**: Only files and directories which have been added by the user, and are not part of the internal lists, can be excluded. So, for example, it is not possible to exclude the 'ps' command by using '/bin/ps'. These will be silently ignored from the configuration.

**_NOTE_**: Whenever this option is changed `rkhunter --propupd` must be run.

**Type**: `array`

**Default value**: `[]`

#### `existwhitelist`

List of files and directories to whitelists existing, or not existing, on the system at the time of testing.

This option is used when the configuration file options themselves are checked, and during the file properties check, the hidden files and directories checks, and the filesystem check of the '/dev' directory.

**_NOTE_**: The user must take into consideration how often the file will appear and disappear from the system in relation to how often rkhunter is run. If the file appears, and disappears, too often then rkhunter may not notice this. All it will see is that the file has changed. The inode-number and DTM will certainly be different for each new file, and rkhunter will report this.

**Type**: `array`

**Default value**: `[]`

#### `attrwhitelist`

List of files to whitelist various attributes of.

The attributes are those of the 'attributes' test. Specifying a file name here does not include it being whitelisted for the write permission test.

**Type**: `array`

**Default value**: `[]`

#### `writewhitelist`

List of files to allow having the 'others' (world) permission have the write-bit set.

For example, files with permissions r-xr-xrwx or rwxrwxrwx.

**Type**: `array`

**Default value**: `[]`

#### `scriptwhitelist`

List of files to allow being a script.

**Type**: `array`

**Default value**: `['/bin/egrep', '/bin/fgrep', '/bin/which', '/usr/bin/groups', '/usr/bin/ldd', '/usr/bin/lwp-request', '/usr/sbin/adduser', '/usr/sbin/prelink', '/sbin/ifup', '/sbin/ifdown']`

#### `immutwhitelist`

List of files to allow having the immutable attribute set.

**Type**: `array`

**Default value**: `[]`

#### `immutable_set`

If set to `true`, then the immutable-bit test is reversed. That is, the files are expected to have the bit set. A value of `false` means that the immutable-bit should not be set.

**Type**: `bool`

**Default value**: `false

#### `allowhiddendir`

List of hidden directories to whitelist.

**Type**: `array`

**Default value**: `[]`

#### `allowhiddenfile`

List of hidden files to whitelist.

**Type**: `array`

**Default value**: `[]`

#### `allowprocdelfile`

List of processes allowed to use deleted files.

The process name may be followed by a colon-separated list of full pathnames. The process will then only be whitelisted if it is using one of the given files. For example:

     class { 'rkhunter":
       allowprocdelfile => ['/usr/libexec/gconfd-2:/tmp/abc:/var/tmp/xyz'],
     }

**Type**: `array`

**Default value**: `[]`

#### `allowproclisten`

List of processes to allow listening on any network interface.

**Type**: `array`

**Default value**: `[]`

#### `allowpromiscif`

List of network interfaces to be allowed in promiscuous mode.

**Type**: `array`

**Default value**: `[]`

#### `scan_mode_dev`

Specifies how rkhunter should scan the '/dev' directory for suspicious files. 

A `'THOROUGH'` scan will increase the overall runtime of rkhunter. Despite this, it is highly recommended that this value is used.

**Type**: `string`

**Default value**: `''`

**Valid values**:

* `''`, an empty string (uses rkhunter default 'THOROUGH')
* `'THOROUGH'`
* `'LAZY'`

#### `phalanx2_dirtest`

This option is used to indicate if the Phalanx2 test is to perform a basic check, or a more thorough check. If the option is set to `false`, then a basic check is performed. If it is set to `true`, then all the directories in the '/etc' and '/usr' directories are scanned.

**_NOTE_**: Setting this option to `true` will cause the test to take longer to complete.

**Type**: `bool`

**Default value**: `false`

#### `allowdevfile`

List of files allowed to be present in the '/dev' directory, and not regarded as suspicious.

**Type**: `array`

**Default value**: `[]`

#### `inetd_conf_path`

Filepath to the inetd configuration file.

**Type**: `string`

**Default value**: `''`

#### `inetd_allowed_svc`

List of allowed inetd services.

For non-Solaris users the simple service name should be used.  For example:

     class { 'rkhunter":
       inetd_allowed_svc => ['echo'],
     }

For Solaris 9 users the simple service name should also be used, but if it is an RPC service, then the executable pathname should be used.  For example:

     class { 'rkhunter":
       inetd_allowed_svc => [
         'imaps',
         '/usr/sbin/rpc.metad',
         '/usr/sbin/rpc.metamhd',
       ],
     }

For Solaris 10 users the service/FMRI name should be used. For example:

     class { 'rkhunter":
       inetd_allowed_svc => [
         '/network/rpc/meta',
         '/network/rpc/metamed',
         '/application/font/stfsloader',
         '/network/rpc-100235_1/rpc_ticotsord',
       ],
     }

**Type**: `array`

**Default value**: `[]`

#### `xinetd_conf_path`

Filepath to the xinetd configuration file.

**Type**: `string`

**Default value**: `''`

#### `xinetd_allowed_svc`

List of allowed xinetd services.

**Type**: `array`

**Default value**: `[]`

#### `startup_paths`

List of file pathnames for the local system.

The directories will be searched for files. By default rkhunter will try and determine were the startup files are located. If the option is set to `[]` or `['NONE']`, then certain tests will be skipped.

**Type**: `array`

**Default value**: `[]`

#### `password_file`

Pathname to the file containing the user account passwords. This setting will be worked out by rkhunter, and so should not usually need to be set. Users of TCB shadow files should not set this option.

**Type**: `string`

**Default value**: `''`

#### `uid0_accounts`

List of accounts to be root equivalent. These accounts will have a UID value of zero. The 'root' account does not need to be listed as it is automatically whitelisted.

**_NOTE_**: For \*BSD systems you will probably need to use this option for the 'toor' account.

**Type**: `array`

**Default value**: `[]`

#### `pwdless_accounts`

List of accounts that are allowed to have no password. NIS/YP entries do not need to be listed as they are automatically whitelisted.

**Type**: `array`

**Default value**: `[]`

#### `syslog_config_file`

List of pathnames to the syslog configuration files.

This setting will be worked out by rkhunter, and so should not usually need to be set.

A value of `[]` or `['NONE']` can be used to indicate that there is no configuration file, but that the syslog daemon process may be running.

**Type**: `array`

**Default value**: `[]`

#### `allow_syslog_remote_logging`

If set to `true`, then the use of syslog remote logging is permitted. A value of `false` disallows the use of remote logging.

**Type**: `bool`

**Default value**: `false`

#### `app_whitelist`

List of applications, or a specific version of an application, to be whitelisted. If a specific version is to be whitelisted, then the name must be followed by a colon and then the version number. For example:

     class { 'rkhunter":
       app_whitelist => [
         'openssl:0.9.7d',
         'gpg',
         'httpd:1.3.29',
       ],
     }

**Type**: `array`

**Default value**: `[]`

#### `suspscan_dirs`

List of directories to scan for suspicious files which pose a relatively higher risk due to user write access.

**_NOTE_**: Do not enable the 'suspscan' test by default as it is CPU and I/O intensive, and prone to producing false positives. Do review all settings before usage. Also be aware that running 'suspscan' in combination with verbose logging on, rkhunter's default, will show all ignored files.

**Type**: `array`

**Default value**: `[]`

#### `suspscan_temp`

Directory for temporary files used by the 'suspcan' test.

A memory-based directory, such as a tempfs filesystem, is better (faster).

Do not use a directory name that is listed in `suspscan_dirs` as that is highly likely to cause false-positive results.

**Type**: `string`

**Default value**: `'/dev/shm'`

#### `suspscan_maxsize`

Set the 'suspscan' test maximum filesize in bytes.

Files larger than this will not be inspected. Do make sure you have enough space available in your temporary files directory.

**Type**: `string` of digits

**Default value**: `'10240000'`

#### `suspscan_thresh`

Set the 'suspscan' test score threshold.

Below this value no hits will be reported.

**Type**: `string` of digits

**Default value**: `'200'`

#### `port_whitelist`

List of ports that should be whitlisted.

The entries should be in the 'protocol:port' form. For example:

     class { 'rkhunter":
       port_whitelist => [
         'TCP:2001',
         'UDP:3201',
       ],
     }

**Type**: `array`

**Default value**: `[]`

#### `os_version_file`

Filepath to the operating system 'release' file.

This file contains information specifying the current O/S version. rkhunter will store this information, and check to see if it has changed between each run. If it has changed, then the user is warned that rkhunter may issue warning messages until rkhunter has been run with the '--propupd' option.

Since the contents of the file vary according to the O/S distribution, rkhunter will perform different actions when it detects the file itself. As such, this option should not be set unless necessary. If this option is specified, then rkhunter will assume the O/S release information is on the first non-blank line of the file.

**Type**: `string`

**Default value**: `''`

#### `rtkt_dir_whitelist`

List of directories to whitelist that would normally be flagged with a warning during the various rootkit and malware checks. Only existing directories can be specified, and these must be full pathnames not links.

**Type**: `array`

**Default value**: `[]`

#### `rtkt_file_whitelist`

List of files to whitelist that would normally be flagged with a warning during the various rootkit and malware checks. Only existing files can be specified, and these must be full pathnames not links.

Additionally, the listed file may include a string after the file name (separated by a colon). This will then only whitelist that string in that file (as part of the malware checks). For example:

     class { 'rkhunter":
       rtkt_file_whitelist => ['/etc/rc.local:hdparm'],
     }

If the option list includes the filename on its own as well, then the file
will be whitelisted from rootkit checks of the files existence, but still
only the specific string within the file will be whitelisted. For example:

     class { 'rkhunter":
       rtkt_file_whitelist => [
         '/etc/rc.local',
         '/etc/rc.local:hdparm',
       ],
     }

To whitelist a file from the existence checks, but not from the strings
checks, then include the filename on its own and on its own but with just
a colon appended. For example:

     class { 'rkhunter":
       rtkt_file_whitelist => [
         '/etc/rc.local',
         '/etc/rc.local:',
       ],
     }

**_NOTE_**: It is recommended that if you whitelist any files, then you include those files in the file properties check. See the `user_fileprop_files_dirs` configuration option.

**Type**: `array`

**Default value**: `[]`

#### `shared_lib_whitelist`

List of shared library files to whitelist.

**_NOTE_**: It is recommended that if you whitelist any files, then you include those files in the file properties check. See the `user_fileprop_files_dirs` configuration option.

**Type**: `array`

**Default value**: `[]`

#### `stat_cmd`

In order to force rkhunter to use the supplied 'stat' command.

**Type**: `string`

**Default value**: `''`

#### `readlink_cmd`

In order to force rkhunter to use the supplied 'readlink' command.

**Type**: `string`

**Default value**: `''`

#### `epoch_date_cmd`

In the file properties test any modification date/time is displayed as the number of epoch seconds. Rkhunter will try and use the 'date' command, or failing that the 'perl' command, to display the date and time in a human-readable format as well.

This sets a command that should be used instead. The given command must understand the '%s' and 'seconds ago' options found in the GNU 'date' command.

A value of `'NONE'` may be used to request that only the epoch seconds be shown.

A value of 'PERL' may be used to force rkhunter to use the 'perl' command, if
it is present.

**Type**: `string`

**Default value**: `''`

#### `modules_dir`

Directory containing the available Linux kernel modules.

This setting will be worked out by rkhunter, and so should not usually need to be set.

**Type**: `string`

**Default value**: `''`

#### `web_cmd`

Command which rkhunter will use when downloading files from the Internet - that is, when the '--update' or '--versioncheck' option is used.

This allows the user to use a command other than the one automatically selected by rkhunter, but still one which it already knows about.  For example:

     class { 'rkhunter":
       web_cmd => 'curl',
     }

Alternatively, you may specify a completely new command. However, note that rkhunter expects the downloaded file to be written to stdout, and that everything written to stderr is ignored. For example:

     class { 'rkhunter":
       web_cmd => '/opt/bin/dlfile --timeout 5m -q',
     }

\*BSD users may want to use the 'ftp' command, provided that it supports the HTTP protocol:

     class { 'rkhunter":
       web_cmd => 'ftp -o -',
     }

**Type**: `string`

**Default value**: `''`

#### `warn_on_os_change`

Set to `false` if you do not want to receive a warning if any O/S information has changed since the last run of 'rkhunter --propupd'. The warnings occur during the file properties check. Setting a value of `true` will cause rkhunter to issue a warning if something has changed.

**Type**: `bool`

**Default value**: `true`

#### `updt_on_os_change`

Set to `true` if you want rkhunter to automatically run a file properties update ('--propupd') if the O/S has changed. Detection of an O/S change occurs during the file properties check. Setting a value of `false` will cause rkhunter not to do an automatic update.

**_WARNING_**: Only set this option if you are sure that the update will work correctly. That is, that the database directory is writeable, that a valid hash function is available, and so on. This can usually be checked simply by running 'rkhunter --propupd' at least once.

**Type**: `bool`

**Default value**: `false`

#### `use_locking`

Set to `true` if locking is to be used when rkhunter runs.

The lock is set just before logging starts, and is removed when the program ends. It is used to prevent items such as the log file, and the file properties file, from becoming corrupted if rkhunter is running more than once. The mechanism used is to simply create a lock file in the `tmpdir` directory. If the lock file already exists, because rkhunter is already running, then the current process simply loops around sleeping for 10 seconds
and then retrying the lock. A value of `false` means not to use locking.

**Type**: `bool`

**Default value**: `false`

#### `lock_timeout`

Set the time, in seconds, that rkhunter should wait in getting the lock.

If locking is used, then rkhunter may have to wait to get the lock file. It will retry the lock every 10 seconds, until either it obtains the lock or the timeout value has been reached.

**Type**: `string` of digits

**Default value**: `'300'` (5 minutes)

#### `show_lock_msgs`

If locking is used, then rkhunter may be doing nothing for some time if it has to wait for the lock. If set to `true`, then some simple messages are echoed to the users screen to let them know that rkhunter is waiting for the lock. If set to `false` the messages are not displayed.

**Type**: `bool`

**Default value**: `true`

#### `scanrootkitmode`

If set to `true` then rkhunter will search (on a per rootkit basis) for filenames in all of the directories (as defined by the result of running 'find / -xdev'). While still not optimal, as it still searches for only file names as opposed to file contents, this is one step away from the rigidity of searching in known (evidence) or default (installation) locations.

**_THIS OPTION SHOULD NOT BE ENABLED BY DEFAULT_**

You should only activate this feature as part of a more thorough investigation, which should be based on relevant best practices and procedures. 

Enabling this feature implies you have the knowledge to interpret the results properly.

**Type**: `bool`

**Default value**: `false`

#### `unhide_tests`

List of names of the tests the 'unhide' command is to use.

Options such as '-m' and '-v' may be specified, but will only take effect when they are seen.

**Type**: `array`

**Default value**: `['sys']`

#### `disable_unhide`

If both the C 'unhide', and Ruby 'unhide.rb', programs exist on the system, then it is possible to disable the execution of one of the programs if desired. By default rkhunter will look for both programs, and execute each of them as they are found.

* If the value of this option is '0', then both programs will be executed if they are present.
* A value of '1' will disable execution of the C 'unhide' program.
* A value of '2' will disable the Ruby 'unhide.rb' program.
* To disable both programs, then disable the 'hidden\_procs' test.

**Type**: `string`

**Default value**: `'1'`

**Valid values**:

* `'0'`
* `'1'`
* `'2'`

#### `install_dir`

Specifies the location where the main rkhunter instal directory is.

**Type**: `string`

**Default value**: `''`

### Resource: rkhunter::propupd

If `files`, `directories`, or `packages` are empty rkhunter will update its database for the entire system.

#### `files`

Files to have rkhunter update in its database.  If a string is given it is expected to be a single files or a space separated list of files.

**Type**: `string` or `list`

**Default value**: `[]`

#### `directories`

Directories to have rkhunter update in its database.  If a string is given it is expected to be a single directory or a space separated list of directories.

**Type**: `string` or `list`

**Default value**: `[]`

#### `packages`

Packages to have rkhunter update in its database.  If a string is given it is expected to be a single package or a space separated list of packages.

**Type**: `string` or `list`

**Default value**: `[]`

## Limitations

Currently rkhunter is only actively tested with the following operating systems:

* Debian 7.x
* CentOS 6.x
* Ubuntu 14.04
