# Install and configure base ceph components
#
# == Parameters
# [*package_ensure*] The ensure state for the ceph package.
#   Optional. Defaults to present.
#
# == Dependencies
#
# none
#
# == Authors
#
#  Stas Alekseev <stas.alekseev@gmail.com>
#

class ceph::install inherits ceph {

  package { 'ceph':
    ensure  => $packages_ensure,
    require => Yumrepo["ceph"],
  }

  #FIXME: Ensure ceph user/group

  file { '/lib/udev/rules.d/95-ceph-osd.rules':
    ensure  => 'present',
    source  => 'puppet:///modules/ceph/95-ceph-osd.rules',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

   file { '/lib/udev/rules.d/95-ceph-osd-alt.rules':
     ensure  => 'present',
     source  => 'puppet:///modules/ceph/95-ceph-osd-alt.rules',
     mode    => '0644',
     owner   => 'root',
     group   => 'root',
   }

  file { '/var/lib/ceph':
    ensure => directory,
    owner  => 'root',
    group  => 0,
    mode   => '0755'
  }

  file { '/var/run/ceph':
    ensure => directory,
    owner  => 'root',
    group  => 0,
    mode   => '0755'
  }

}
