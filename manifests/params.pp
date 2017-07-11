  # Class: cfssl::params
#
class cfssl::params {
  $wget_manage      = true
  $download_url     = 'https://pkg.cfssl.org/R1.2'
  $keys_dir         = "${conf_dir}/keys"
  $certs_dir        = "${conf_dir}/certs"

  case $::kernel {
    'Linux': {
      $download_dir     = '/opt/cfssl'
      $install_dir      = '/usr/local/bin'
      $conf_dir         = '/etc/cfssl'
      $provider         = 'shell'
    }
    'Windows': {
      $download_dir     = 'c:/Windows/Temp/cfssl'
      $install_dir      = 'c:/Windows/System32/WindowsPowerShell/v1.0'
      $conf_dir         = 'c:/cfssl'
      $provider         = 'powershell'
    }
  }

  $arch = $::facts['architecture'] ? {
    'i386'  => '386',
    default => 'amd64',
  }
  $binaries   = {
    'cfssl-bundle'    => "cfssl-bundle_${::kernel}-${arch}",
    'cfssl-certinfo'  => "cfssl-certinfo_${::kernel}-${arch}",
    'cfssl-newkey'    => "cfssl-newkey_${::kernel}-${arch}",
    'cfssl-scan'      => "cfssl-scan_${::kernel}-${arch}",
    'cfssl'           => "cfssl_${::kernel}-${arch}",
    'cfssljson'       => "cfssljson_${::kernel}-${arch}",
    'mkbundle'        => "mkbundle_${::kernel}-${arch}",
    'multirootca'     => "multirootca_${::kernel}-${arch}",
  }

  $ca_manage               = false
  $key_algo                = 'rsa'
  $key_size                = 4096
  $root_ca_id              = 'ca'
  $root_ca_name            = 'My Root CA'
  $root_ca_expire          = '262800h' #30 years (24x356x30)
  $intermediate_ca_id      = 'intermediate-ca'
  $intermediate_ca_name    = 'My Intermediate CA'
  $intermediate_ca_expire  = '42720h'
  $cr_server_expire        = '35040h' #default fours years
  $cr_client_expire        = '35040h' #default fours years
  $cr_client_server_expire = '35040h' #default fours years
  $country                 = 'UK'
  $state                   = 'England'
  $city                    = 'Leeds'
  $organization            = 'My Company'
  $org_unit                = 'My Unit'

  $service_manage   = $ca_manage
  $service_ensure   = 'running'
  $service_enable   = true
  $service_name     = 'cfssl'
  $service_address  = '127.0.0.1'
  $service_port     = 8888
  $service_user     = 'root'
  $firewall_manage  = false
  $allowed_networks = [ '127.0.0.0/8' ]
}
