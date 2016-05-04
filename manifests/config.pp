class ssh::config inherits ssh {
#Generate RSA keys reliably
  $mydir = "ssh/${::fqdn}"
#see funct, but default size= 2048bit
  $rsa_priv = ssh_keygen({name => "ssh_host_rsa_${::fqdn}", dir =>$mydir})
  $rsa_pub  = ssh_keygen({name => "ssh_host_rsa_${::fqdn}", dir =>$mydir, public => 'true'})

#ecdsa is either 256/384/512 bit for size value !
  $ecdsa_priv = ssh_keygen({name => "ssh_host_ecdsa_${::fqdn}", dir =>$dir, type => 'ecdsa', size => '256'})
   $ecdsa_pub = ssh_keygen({name => "ssh_host_ecdsa_${::fqdn}", dir =>$dir, type => 'ecdsa', size => '256', public => 'true'})

#ed25519 is either 256/384/512 bit for size value !
  $ed25519_priv = ssh_keygen({name => "ssh_host_ed25519_${::fqdn}", dir =>$dir, type => 'ed25519', size => '256'})
  $ed25519_pub = ssh_keygen({name => "ssh_host_ed25519_${::fqdn}", dir =>$dir, type => 'ed25519', size => '256',public => 'true'})

  file { '/etc/ssh/ssh_host_ecdsa_key':
    owner   => 'root',
    group   => $groupowner,
    mode    => 0600,
    content => $ecdsa_priv,
    notify => Class [ssh::service],
  }

  file { '/etc/ssh/ssh_host_ecdsa_key.pub':
    owner   => 'root',
    group   => $groupowner,
    mode    => 0644,
    content => template('ssh/ecdsa_key.pub.erb'),
   notify => Class [ssh::service],
  }

  file { '/etc/ssh/ssh_host_ed25519_key':
    owner   => 'root',
    group   => $groupowner,
    mode    => 0600,
    content => $ed25519_priv,
    notify => Class [ssh::service],
  }

  file { '/etc/ssh/ssh_host_ed25519_key.pub':
    owner   => 'root',
    group   => $groupowner,
    mode    => 0644,
    content => template('ssh/ed25519_key.pub.erb'),
   notify => Class [ssh::service],
}

  file { '/etc/ssh/ssh_host_rsa_key':
    owner   => 'root',
    group   => $groupowner,
    mode    => 0600,
    content => $rsa_priv,
    notify => Class [ssh::service],
  }

  file { '/etc/ssh/ssh_host_rsa_key.pub':
    owner   => 'root',
    group   => $groupowner,
    mode    => 0644,
    content => template('ssh/rsa_key.pub.erb'),
   notify => Class [ssh::service],
  }

  file { '/etc/ssh/sshd_config':
    owner   => 'root',
    group   => $groupowner,
    mode    => '0644',
    content => template($config),
   notify => Class [ssh::service],
  }


}
