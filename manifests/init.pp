# == Class: rkhunter
#
# This class installs and configures rkhunter.
#
# === Authors
#
# Tyler Yahn <codingalias@gmail.com>
#
class rkhunter (
  $ensure                           = $rkhunter::params::ensure,
  $config_content                   = $rkhunter::params::config_content,
  $rotate_mirrors                   = $rkhunter::params::rotate_mirrors,
  $update_mirrors                   = $rkhunter::params::update_mirrors,
  $mirrors_mode                     = $rkhunter::params::mirrors_mode,
  $mail_on_warning                  = $rkhunter::params::mail_on_warning,
  $mail_cmd                         = $rkhunter::params::mail_cmd,
  $tmpdir                           = $rkhunter::params::tmpdir,
  $dbdir                            = $rkhunter::params::dbdir,
  $scriptdir                        = $rkhunter::params::scriptdir,
  $bindir                           = $rkhunter::params::bindir,
  $language                         = $rkhunter::params::language,
  $update_lang                      = $rkhunter::params::update_lang,
  $logfile                          = $rkhunter::params::logfile,
  $append_log                       = $rkhunter::params::append_log,
  $copy_log_on_error                = $rkhunter::params::copy_log_on_error,
  $use_syslog                       = $rkhunter::params::use_syslog,
  $color_set2                       = $rkhunter::params::color_set2,
  $auto_x_detect                    = $rkhunter::params::auto_x_detect,
  $whitelisted_is_white             = $rkhunter::params::whitelisted_is_white,
  $allow_ssh_root_user              = $rkhunter::params::allow_ssh_root_user,
  $allow_ssh_prot_v1                = $rkhunter::params::allow_ssh_prot_v1,
  $ssh_config_dir                   = $rkhunter::params::ssh_config_dir,
  $enable_tests                     = $rkhunter::params::enable_tests,
  $disable_tests                    = $rkhunter::params::disable_tests,
  $hash_func                        = $rkhunter::params::hash_func,
  $hash_fld_idx                     = $rkhunter::params::hash_fld_idx,
  $pkgmgr                           = $rkhunter::params::pkgmgr,
  $pkgmgr_no_vrfy                   = $rkhunter::params::pkgmgr_no_vrfy,
  $ignore_prelink_dep_err           = $rkhunter::params::ignore_prelink_dep_err,
  $use_sunsum                       = $rkhunter::params::use_sunsum,
  $user_fileprop_files_dirs         = $rkhunter::params::user_fileprop_files_dirs,
  $exclude_user_fileprop_files_dirs = $rkhunter::params::exclude_user_fileprop_files_dirs,
  $existwhitelist                   = $rkhunter::params::existwhitelist,
  $attrwhitelist                    = $rkhunter::params::attrwhitelist,
  $writewhitelist                   = $rkhunter::params::writewhitelist,
  $scriptwhitelist                  = $rkhunter::params::scriptwhitelist,
  $immutwhitelist                   = $rkhunter::params::immutwhitelist,
  $immutable_set                    = $rkhunter::params::immutable_set,
  $allowhiddendir                   = $rkhunter::params::allowhiddendir,
  $allowhiddenfile                  = $rkhunter::params::allowhiddenfile,
  $allowprocdelfile                 = $rkhunter::params::allowprocdelfile,
  $allowproclisten                  = $rkhunter::params::allowproclisten,
  $allowpromiscif                   = $rkhunter::params::allowpromiscif,
  $scan_mode_dev                    = $rkhunter::params::scan_mode_dev,
  $phalanx2_dirtest                 = $rkhunter::params::phalanx2_dirtest,
  $allowdevfile                     = $rkhunter::params::allowdevfile,
  $inetd_conf_path                  = $rkhunter::params::inetd_conf_path,
  $inetd_allowed_svc                = $rkhunter::params::inetd_allowed_svc,
  $xinetd_conf_path                 = $rkhunter::params::xinetd_conf_path,
  $xinetd_allowed_svc               = $rkhunter::params::xinetd_allowed_svc,
  $startup_paths                    = $rkhunter::params::startup_paths,
  $password_file                    = $rkhunter::params::password_file,
  $uid0_accounts                    = $rkhunter::params::uid0_accounts,
  $pwdless_accounts                 = $rkhunter::params::pwdless_accounts,
  $syslog_config_file               = $rkhunter::params::syslog_config_file,
  $allow_syslog_remote_logging      = $rkhunter::params::allow_syslog_remote_logging,
  $app_whitelist                    = $rkhunter::params::app_whitelist,
  $suspscan_dirs                    = $rkhunter::params::suspscan_dirs,
  $suspscan_temp                    = $rkhunter::params::suspscan_temp,
  $suspscan_maxsize                 = $rkhunter::params::suspscan_maxsize,
  $suspscan_thresh                  = $rkhunter::params::suspscan_thresh,
  $port_whitelist                   = $rkhunter::params::port_whitelist,
  $os_version_file                  = $rkhunter::params::os_version_file,
  $rtkt_dir_whitelist               = $rkhunter::params::rtkt_dir_whitelist,
  $rtkt_file_whitelist              = $rkhunter::params::rtkt_file_whitelist,
  $shared_lib_whitelist             = $rkhunter::params::shared_lib_whitelist,
  $stat_cmd                         = $rkhunter::params::stat_cmd,
  $readlink_cmd                     = $rkhunter::params::readlink_cmd,
  $epoch_date_cmd                   = $rkhunter::params::epoch_date_cmd,
  $modules_dir                      = $rkhunter::params::modules_dir,
  $web_cmd                          = $rkhunter::params::web_cmd,
  $warn_on_os_change                = $rkhunter::params::warn_on_os_change,
  $updt_on_os_change                = $rkhunter::params::updt_on_os_change,
  $use_locking                      = $rkhunter::params::use_locking,
  $lock_timeout                     = $rkhunter::params::lock_timeout,
  $show_lock_msgs                   = $rkhunter::params::show_lock_msgs,
  $scanrootkitmode                  = $rkhunter::params::scanrootkitmode,
  $unhide_tests                     = $rkhunter::params::unhide_tests,
  $disable_unhide                   = $rkhunter::params::disable_unhide,
  $installdir                       = $rkhunter::params::installdir,
) inherits rkhunter::params {
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

  $_file_ensure = $ensure ? {
    /^(present|installed|held|latest)$/ => 'file',
    default                             => 'absent',
  }

  file { '/etc/rkhunter.conf':
    ensure  => $_file_ensure,
    content => $config_content,
    require => Package['rkhunter'],
  }

  exec { 'Check rkhunter config':
    command     => '/usr/bin/rkhunter --config-check',
    refreshonly => true,
    subscribe   => File['/etc/rkhunter.conf'],
  }
}
