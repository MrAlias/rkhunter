# == Type: rkhunter::propupd
#
# RKHunter property update type.
#
# This defined type is intended to update the entire system or just
# specific files, directories, or packages.
#
# WARNING:  It  is  the  users responsibility to ensure that the files
# on the system are genuine and from a reliable source.
#
# === Parameters
#
# [*files*]
#  String or list of files to have rkhunter update its stored hash for.
#  If a string is used it is expected to be a single files or a space
#  serperated list of files.
#
# [*directories*]
#  String or list of directories to have rkhunter update its stored hash for.
#  If a string is used it is expected to be a single directory or a space
#  serperated list of directories.
#
# [*packages*]
#  String or list of packages to have rkhunter update its stored hash for.
#  If a string is used it is expected to be a single package or a space
#  serperated list of packages.
#
# === Example
#
# Update the rkhunter database after updating the Sudo package.
#
#   rkhunter::propupd { 'sudo':
#     package   => 'sudo',
#     subscribe => Package['sudo'],
#   }
#
# Update the rkhunter database after changing the openssh-server
# configuration.
#
#   rkhunter::propupd { 'sshd_config':
#     file      => '/etc/ssh/sshd_config',
#     subscribe => File['sshd_config'],
#   }
#
# Update the rkhunter database after modifying multiple PostgreSQL
# configuration files.
#
#   rkhunter::propupd { 'postgresql configs':
#     file      => [
#       '/etc/postgresql/9.1/main/pg_hba.conf',
#       '/etc/postgresql/9.1/main/pg_ident.conf',
#       '/etc/postgresql/9.1/main/postgresql.conf',
#     ],
#     subscribe => [
#       File['/etc/postgresql/9.1/main/pg_hba.conf'],
#       File['/etc/postgresql/9.1/main/pg_ident.conf'],
#       File['/etc/postgresql/9.1/main/postgresql.conf'],
#     ],
#   }
#
# Another possibility to update the PostgreSQL configuration files
# would be to just update the entire directory.
#
#   rkhunter::propupd { 'postgresql configs':
#     directory => '/etc/postgresql/9.1/main/',
#     subscribe => [
#       File['/etc/postgresql/9.1/main/pg_hba.conf'],
#       File['/etc/postgresql/9.1/main/pg_ident.conf'],
#       File['/etc/postgresql/9.1/main/postgresql.conf'],
#     ],
#   }
#
# === Authors
#
# Tyler Yahn <codingalias@gmail.com>
#
define rkhunter::propupd (
  $files       = [],
  $directories = [],
  $packages    = [],
) {
  $_files = is_array($files) ? {
    true  => join($files, ' '),
    false => $files,
  }

  $_directories = is_array($directories) ? {
    true  => join($directories, ' '),
    false => $directories,
  }

  $_packages = is_array($packages) ? {
    true  => join($packages, ' '),
    false => $packages,
  }

  $items = join([$_files, $_directories, $_packages], ' ')

  exec { "rkhunter-propupd ${name}:${items}":
    command => "/usr/bin/rkhunter --propupd ${items}",
    require => Package['rkhunter'],
  }
}
