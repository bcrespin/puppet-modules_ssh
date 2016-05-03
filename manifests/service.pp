class ssh::service inherits ssh{
	service { 'sshd':
    		ensure => running,
    		enable => true,
		name => $service_name,
		hasstatus => true,
		hasrestart => true,
  	}
}
