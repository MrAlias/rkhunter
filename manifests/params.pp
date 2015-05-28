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
  if $::osfamily != 'Debian' and $::osfamily != 'RedHat' {
    fail("${module_name} does not support the ${::operatingsystem} OS.")
  }

  $ensure = 'present'

  $rotate_mirrors = true

  $update_mirrors = true

  $mirrors_mode = 'any'

  $mail_on_warning = []

  $mail_cmd = "mail -s \"[rkhunter] Warnings found for ${hostname}\""

  $tmpdir = $::osfamily ? {
    'RedHat' => '/var/lib/rkhunter',
    default  => '/var/lib/rkhunter/tmp',
  }

  $dbdir = '/var/lib/rkhunter/db'

  $scriptdir = '/usr/share/rkhunter/scripts'

  $bindir = []

  $language = ''

  $update_lang = []

  $logfile = $::osfamily ? {
    'RedHat' => '/var/log/rkhunter/rkhunter.log',
    default  => '/var/log/rkhunter.log',
  }

  $append_log = $::osfamily ? {
    'RedHat' => true,
    default  => false,
  }

  $copy_log_on_error = false

  $use_syslog = ''

  $color_set2 = false

  $auto_x_detect = true

  $whitelisted_is_white = false

  $allow_ssh_root_user = $::osfamily ? {
    'RedHat' => 'unset',
    default  => 'no',
  }

  $allow_ssh_prot_v1 = $::osfamily ? {
    'RedHat' => '2',
    default  => '0',
  }

  $ssh_config_dir = ''

  $enable_tests = ['all']

  $disable_tests = $::osfamily ? {
    'Debian' => [
      'suspscan',
      'hidden_procs',
      'deleted_files',
      'packet_cap_apps',
      'apps'
    ],
    'RedHat' => [
      'suspscan',
      'hidden_ports',
      'deleted_files',
      'packet_cap_apps',
      'apps',
    ],
    default  => []
  }

  $hash_func = ''

  $hash_fld_idx = 1

  $pkgmgr = $::osfamily ? {
    'RedHat' => 'RPM',
    default  => '',
  }

  $pkgmgr_no_vrfy = []

  $ignore_prelink_dep_err = []

  $use_sunsum = false

  $user_fileprop_files_dirs = []

  $exclude_user_fileprop_files_dirs = []

  $existwhitelist = []

  $attrwhitelist = []

  $writewhitelist = []

  $scriptwhitelist = $::osfamily ? {
    'Debian' => [
      '/bin/egrep',
      '/bin/fgrep',
      '/bin/which',
      '/usr/bin/groups',
      '/usr/bin/ldd',
      '/usr/bin/lwp-request',
      '/usr/sbin/adduser',
      '/usr/sbin/prelink',
      '/sbin/ifup',
      '/sbin/ifdown',
    ],
    'RedHat' => [
      '/usr/bin/whatis',
      '/usr/bin/ldd',
      '/usr/bin/groups',
      '/sbin/ifup',
      '/sbin/ifdown',
    ],
    default  => [],
  }

  $immutwhitelist = []

  $immutable_set = false

  $allowhiddendir = $::osfamily ? {
    'RedHat' => [
      '/etc/.java',
      '/dev/.udev',
      '/dev/.udevdb',
      '/dev/.udev.tdb',
      '/dev/.static',
      '/dev/.initramfs',
      '/dev/.SRC-unix',
      '/dev/.mdadm',
      '/dev/.systemd',
      '/dev/.mount',
      '/etc/.git',
      '/etc/.bzr',
    ],
    default  => [],
  }

  $allowhiddenfile = $::osfamily ? {
    'RedHat' => [
      '/usr/share/man/man1/..1.gz',
      '/lib*/.libcrypto.so.*.hmac',
      '/lib*/.libssl.so.*.hmac',
      '/usr/bin/.fipscheck.hmac',
      '/usr/bin/.ssh.hmac',
      '/usr/bin/.ssh-keygen.hmac',
      '/usr/bin/.ssh-keyscan.hmac',
      '/usr/bin/.ssh-add.hmac',
      '/usr/bin/.ssh-agent.hmac',
      '/usr/lib*/.libfipscheck.so.*.hmac',
      '/usr/lib*/.libgcrypt.so.*.hmac',
      '/usr/lib*/hmaccalc/sha1hmac.hmac',
      '/usr/lib*/hmaccalc/sha256hmac.hmac',
      '/usr/lib*/hmaccalc/sha384hmac.hmac',
      '/usr/lib*/hmaccalc/sha512hmac.hmac',
      '/usr/sbin/.sshd.hmac',
      '/dev/.mdadm.map',
      '/usr/share/man/man5/.k5login.5.gz',
      '/usr/share/man/man5/.k5identity.5.gz',
      '/usr/sbin/.ipsec.hmac',
      '/etc/.etckeeper',
      '/etc/.gitignore',
      '/etc/.bzrignore',
    ],
    default  => [],
  }

  $allowprocdelfile = []

  $allowproclisten = []

  $allowpromiscif = []

  $scan_mode_dev = ''

  $phalanx2_dirtest = false

  $allowdevfile = $::osfamily ? {
    'RedHat' => [
      '/dev/shm/pulse-shm-*',
      '/dev/md/md-device-map',
      '/dev/shm/mono.*',
      '/dev/shm/libv4l-*',
      '/dev/shm/spice.*',
      '/dev/md/autorebuild.pid',
      '/dev/shm/sem.slapd-*.stats',
    ],
    default  => [],
  }

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

  $rtkt_file_whitelist = $::osfamily ? {
    'RedHat' => [
      '/bin/ad',
      '/var/log/pki-ca/system',
      '/var/log/pki/pki-tomcat/ca/system',
    ],
    default  => [],
  }

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

  $installdir = $::osfamily ? {
    'RedHat' => '/usr',
    default  => '',
  }

  # This needs to be last. All variables need to be set before the template
  # function renders the template.
  $config_content = template("${module_name}/rkhunter.conf.erb")
}
