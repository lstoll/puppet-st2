# == Class: st2::profile::web
#
#  Profile to install StackStorm web client (st2web). This feature is
#  currently under active development, and limited to early access users.
#  If you would like to try this out, please send an email to support@stackstorm.com
#  and let us know!
#
# === Parameters
#
#  [*api_url*]  - URL of st2_api service -- ex: http://127.0.0.1:9101
#  [*auth_url*] - URL of st2_api service -- ex: http://127.0.0.1:9100
#  [*version*]  - Version of StackStorm WebUI to install
#
# === Variables
#
#  This class has no variables
#
# === Examples
#
#  include ::st2::profile::web
#
class st2::profile::web(
  $api_url  = $::st2::api_url,
  $auth_url = $::st2::auth_url,
  $version  = $::st2::version,
) inherits st2 {
  file { [
      '/opt/stackstorm/static',
      '/opt/stackstorm/static/webui',
    ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  wget::fetch { 'st2web':
    source      => "http://ops.stackstorm.net/releases/st2/${version}/webui/webui-${version}.tar.gz",
    cache_dir   => '/var/cache/wget',
    destination => '/tmp/st2web.tar.gz',
    before      => Exec['extract webui'],
  }

  exec { 'extract webui':
    command => 'tar -xzvf /tmp/st2web.tar.gz -C /opt/stackstorm/static/webui --strip-components=1 --owner root --group root --no-same-owner',
    creates => '/opt/stackstorm/static/webui/index.html',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => File['/opt/stackstorm/static/webui'],
  }

  # This is crude... get some augeas on
  ## Manage connection list currently
  file { '/opt/stackstorm/static/webui/config.js':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('st2/opt/st2web/config.js.erb'),
    require => Exec['extract webui'],
  }
}
