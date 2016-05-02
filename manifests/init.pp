# Basic SSH module
#
#
class ssh {

#  package { 'openssh-server': ensure => installed }
  ~>
  file { '/etc/ssh/sshd_config':
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template('ssh/FreeBSD_sshd.conf.erb')
  }
  ~>
  service { 'sshd':
    ensure => running,
    enable => true,
  }

  # Generate RSA keys reliably
  $rsa_priv = ssh_keygen({name => "ssh_host_rsa_${::fqdn}", dir => 'ssh/hostkeys'}) 
  $rsa_pub  = ssh_keygen({name => "ssh_host_rsa_${::fqdn}", dir => 'ssh/hostkeys', public => 'true'}) 

  file { '/etc/ssh/ssh_host_rsa_key':
    owner   => 'root',
    group   => 'wheel',
    mode    => 0600,
    content => $rsa_priv,
  }

  file { '/etc/ssh/ssh_host_rsa_key.pub':
    owner   => 'root',
    group   => 'wheel',
    mode    => 0644,
    content => $rsa_pub,
  }
