class ssh::params {

case $operatingsystem {
	'FreeBSD' :
		{	$config = 'ssh/FreeBSD_sshd.conf.erb'
			$groupowner = 'wheel'
			$package_name = 'BUILTIN'
			$service_name = 'sshd'

		}
	'Default' : 
		{
		       $config = 'ssh/FreeBSD_sshd.conf.erb'
                        $groupowner = 'root'
                        $package_name = 'openssh-server'
                        $service_name = 'sshd'
		 }
}

}
