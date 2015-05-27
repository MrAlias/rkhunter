# == Class: rkhunter::params
#
# This class defines rkhunter default parameters.
#
# Differences in OS names and paths are handled here.
#
# == Variables
#
# Refer to rkhunter class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
# === Authors
#
# Tyler Yahn <codingalias@gmail.com>
#
class rkhunter::params {
  $ensure = 'present'

  $config_template = undef

  $config_file = undef

  $rotate_mirrors = true

  $update_mirrors = true

  $mirrors_mode = 'any'

  $mail_on_warning = []

  $mail_cmd = "mail -s \"[rkhunter] Warnings found for ${hostname}\""

  $tmpdir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/lib/rkhunter/tmp',
    default                   => '/var/lib/rkhunter',
  }

  $dbdir = '/var/lib/rkhunter/db'

  $scriptdir = '/usr/share/rkhunter/scripts'

  $bindir = []

  $language = ''

  $update_lang = []

  $logfile = '/var/log/rkhunter.log'

  $append_log = false

  $copy_log_on_error = false

  $use_syslog = ''

  $color_set2 = false

  $auto_x_detect = true

  $whitelisted_is_white = false

  $allow_ssh_root_user = 'no'

  $allow_ssh_prot_v1 = '0'

  $ssh_config_dir = ''

  $enable_tests = ['all']

  $disable_tests = [
    'suspscan',
    'hidden_procs',
    'deleted_files',
    'packet_cap_apps',
    'apps'
  ]

  $hash_func = ''

  $hash_fld_idx = 1

  $pkgmgr = ''

  $pkgmgr_no_vrfy = []

  $ignore_prelink_dep_err = []

  $use_sunsum = false

  $user_fileprop_files_dirs = []

  $exclude_user_fileprop_files_dirs = []

  $existwhitelist = []

  $attrwhitelist = []

  $writewhitelist = []

  $scriptwhitelist = [
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
  ]

  $immutwhitelist = []

  $immutable_set = false

  $allowhiddendir = []

  $allowhiddenfile = []

  $allowprocdelfile = []

  $allowproclisten = []

  $allowpromiscif = []

  $scan_mode_dev = ''

  $phalanx2_dirtest = false

  $allowdevfile = []

  $inetd_conf_path = ''

  $inetd_allowed_svc = []

  $xinetd_conf_path = ''

  $xinetd_allowed_svc = []

  $startup_paths = []

  $password_file = ''

  $uid0_accounts = []

  $pwdless_accounts = []

  $syslog_config_file = []

  $allow_syslog_remote_logging = false

  $app_whitelist = []

  $suspscan_dirs = []

  $suspscan_temp = '/dev/shm'

  $suspscan_maxsize = '10240000'

  $suspscan_thresh = '200'

  $port_whitelist = []

  $os_version_file = ''

  $rtkt_dir_whitelist = []

  $rtkt_file_whitelist = []

  $shared_lib_whitelist = []

  $stat_cmd = ''

  $readlink_cmd = ''

  $epoch_date_cmd = ''

  $modules_dir = ''

  $web_cmd = ''

  $warn_on_os_change = true

  $updt_on_os_change = false

  $use_locking = false

  $lock_timeout = '300'

  $show_lock_msgs = true

  $scanrootkitmode = false

  $unhide_tests = ['sys']

  $disable_unhide = '1'
}
