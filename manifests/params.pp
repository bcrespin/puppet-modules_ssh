class ssh::params {

$config = 'templates/sshd.conf.erb'
$groupowner = 'root'
$package_name = 'openssh-server'
$service_name = 'sshd'


case $operatingsystem {
	'FreeBSD' :
		{	$config => 'templates/FreeBSD_sshd.conf.erb',
			$groupowner => 'wheel',
			$package_name => 'BUILTIN',
		}
	'Default' : 
		{ }
}

}
