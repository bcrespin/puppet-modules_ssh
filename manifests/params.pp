class ssh::params {

case $operatingsystem {
	'FreeBSD' :
		{	$config = 'templates/FreeBSD_sshd.conf.erb'
			$groupowner = 'wheel'
			$package_name = 'BUILTIN'
			$service_name = 'sshd'

		}
	'Default' : 
		{
		       $config = 'templates/FreeBSD_sshd.conf.erb'
                        $groupowner = 'root'
                        $package_name = 'openssh-server'
                        $service_name = 'sshd'
		 }
}

}
