class ssh::service inherits ssh{
	service { '$service_name':
    		ensure => running,
    		enable => true,
		name => service_name,
		hasstatus => true,
		hasrestart => true,
  	}
}
