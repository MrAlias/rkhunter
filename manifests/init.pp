# == Class: rkhunter
#
# This class installs and configures rkhunter.
#
# === Authors
#
# Tyler Yahn <codingalias@gmail.com>
#
class rkhunter (
  $ensure                           = 'present',
  $config_template                  = undef,
  $config_file                      = undef,
  $rotate_mirrors                   = true,
  $update_mirrors                   = true,
  $mirrors_mode                     = 'any',
  $mail_on_warning                  = [],
  $mail_cmd                         = "mail -s \"[rkhunter] Warnings found for ${hostname}\"",
  $tmpdir                           = '/var/lib/rkhunter/tmp',
  $dbdir                            = '/var/lib/rkhunter/db',
  $scriptdir                        = '/usr/share/rkhunter/scripts',
  $bindir                           = [],
  $language                         = '',
  $update_lang                      = [],
  $logfile                          = '/var/log/rkhunter.log',
  $append_log                       = false,
  $copy_log_on_error                = false,
  $use_syslog                       = '',
  $color_set2                       = false,
  $auto_x_detect                    = true,
  $whitelisted_is_white             = false,
  $allow_ssh_root_user              = 'no',
  $allow_ssh_prot_v1                = '0',
  $ssh_config_dir                   = '',
  $enable_tests                     = ['all'],
  $disable_tests                    = [
    'suspscan',
    'hidden_procs',
    'deleted_files',
    'packet_cap_apps',
    'apps'
  ],
  $hash_func                        = '',
  $hash_fld_idx                     = 1,
  $pkgmgr                           = '',
  $pkgmgr_no_vrfy                   = [],
  $ignore_prelink_dep_err           = [],
  $use_sunsum                       = false,
  $user_fileprop_files_dirs         = [],
  $exclude_user_fileprop_files_dirs = [],
  $existwhitelist                   = [],
  $attrwhitelist                    = [],
  $writewhitelist                   = [],
  $scriptwhitelist                  = [
    '/bin/egrep',
    '/bin/fgrep',
    '/bin/which',
    '/usr/bin/groups',
    '/usr/bin/ldd',
    '/usr/bin/lwp-request',
    '/usr/sbin/adduser',
    '/usr/sbin/prelink',
    '/sbin/ifup',
    '/sbin/ifdown'
  ],
  $immutwhitelist                   = [],
  $immutable_set                    = false,
  $allowhiddendir                   = [],
  $allowhiddenfile                  = [],
  $allowprocdelfile                 = [],
  $allowproclisten                  = [],
  $allowpromiscif                   = [],
  $scan_mode_dev                    = '',
  $phalanx2_dirtest                 = false,
  $allowdevfile                     = [],
  $inetd_conf_path                  = '',
  $inetd_allowed_svc                = [],
  $xinetd_conf_path                 = '',
  $xinetd_allowed_svc               = [],
  $startup_paths                    = [],
  $password_file                    = '',
  $uid0_accounts                    = [],
  $pwdless_accounts                 = [],
  $syslog_config_file               = [],
  $allow_syslog_remote_logging      = false,
  $app_whitelist                    = [],
  $suspscan_dirs                    = [],
  $suspscan_temp                    = '/dev/shm',
  $suspscan_maxsize                 = '10240000',
  $suspscan_thresh                  = '200',
  $port_whitelist                   = [],
  $os_version_file                  = '',
  $rtkt_dir_whitelist               = [],
  $rtkt_file_whitelist              = [],
  $shared_lib_whitelist             = [],
  $stat_cmd                         = '',
  $readlink_cmd                     = '',
  $epoch_date_cmd                   = '',
  $modules_dir                      = '',
  $web_cmd                          = '',
  $warn_on_os_change                = true,
  $updt_on_os_change                = false,
  $use_locking                      = false,
  $lock_timeout                     = '300',
  $show_lock_msgs                   = true,
  $scanrootkitmode                  = false,
  $unhide_tests                     = ['sys'],
  $disable_unhide                   = '1',
) {
  validate_bool($rotate_mirrors)
  validate_bool($update_mirrors)
  validate_re($mirrors_mode, ['any', 'local', 'remote'])
  validate_array($mail_on_warning)
  validate_string($mail_cmd)
  validate_string($tmpdir)
  validate_string($dbdir)
  validate_string($scriptdir)
  validate_array($bindir)
  validate_string($language)
  validate_array($update_lang)
  validate_string($logfile)
  validate_bool($append_log)
  validate_bool($copy_log_on_error)
  validate_string($use_syslog)
  validate_bool($color_set2)
  validate_bool($auto_x_detect)
  validate_bool($whitelisted_is_white)
  validate_re($allow_ssh_root_user, [
    'yes',
    'unset',
    'without-password',
    'forced-commands-only',
    'no'
  ])
  validate_re($allow_ssh_prot_v1, ['0', '1', '2'])
  validate_string($ssh_config_dir)
  validate_array($enable_tests)
  validate_array($disable_tests)
  validate_string($hash_func)
  validate_integer($hash_fld_idx, undef, 1)
  validate_re($pkgmgr, ['', 'NONE', 'RPM', 'DPKG', 'BSD', 'SOLARIS'])
  validate_array($pkgmgr_no_vrfy)
  validate_array($ignore_prelink_dep_err)
  validate_bool($use_sunsum)
  validate_array($user_fileprop_files_dirs)
  validate_array($exclude_user_fileprop_files_dirs)
  validate_array($existwhitelist)
  validate_array($attrwhitelist)
  validate_array($writewhitelist)
  validate_array($scriptwhitelist)
  validate_array($immutwhitelist)
  validate_bool($immutable_set)
  validate_array($allowhiddendir)
  validate_array($allowhiddenfile)
  validate_array($allowprocdelfile)
  validate_array($allowproclisten)
  validate_array($allowpromiscif)
  validate_re($scan_mode_dev, ['', 'THOROUGH', 'LAZY'])
  validate_bool($phalanx2_dirtest)
  validate_array($allowdevfile)
  validate_string($inetd_conf_path)
  validate_array($inetd_allowed_svc)
  validate_string($xinetd_conf_path)
  validate_array($xinetd_allowed_svc)
  validate_array($startup_paths)
  validate_string($password_file)
  validate_array($uid0_accounts)
  validate_array($pwdless_accounts)
  validate_array($syslog_config_file)
  validate_bool($allow_syslog_remote_logging)
  validate_array($app_whitelist)
  validate_array($suspscan_dirs)
  validate_string($suspscan_temp)
  validate_re($suspscan_maxsize, '^\d+$')
  validate_re($suspscan_thresh, '^\d+$')
  validate_array($port_whitelist)
  validate_string($os_version_file)
  validate_array($rtkt_dir_whitelist)
  validate_array($rtkt_file_whitelist)
  validate_array($shared_lib_whitelist)
  validate_string($stat_cmd)
  validate_string($readlink_cmd)
  validate_string($epoch_date_cmd)
  validate_string($modules_dir)
  validate_string($web_cmd)
  validate_bool($warn_on_os_change)
  validate_bool($updt_on_os_change)
  validate_bool($use_locking)
  validate_re($lock_timeout, '^\d+$')
  validate_bool($show_lock_msgs)
  validate_bool($scanrootkitmode)
  validate_array($unhide_tests)
  validate_re($disable_unhide, ['0', '1', '2'])

  package { 'rkhunter':
    ensure => $ensure,
  }

  if (!$config_file) {
    if (!$config_template) {
      $content = template("${module_name}/rkhunter.conf.erb")
    } else {
      $content = template($config_template)
    }
    $source  = undef
  } elsif (!$config_template) {
    $source  = file($config_file)
    $content = undef
  } else {
    fail('Cannot define both config_file and config_template')
  }

  if $ensure =~ /^(present|installed|held|latest)$/ {
    file { '/etc/rkhunter.conf':
      ensure  => file,
      content => $content,
      source  => $source,
      require => Package['rkhunter'],
    }

    exec { 'Check rkhunter config':
      command     => '/usr/bin/rkhunter --config-check',
      refreshonly => true,
      subscribe   => File['/etc/rkhunter.conf'],
    }
  }
}
