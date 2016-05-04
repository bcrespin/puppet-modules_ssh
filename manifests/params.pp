class ssh::params {

$rsa_key_size = 2048
$ecdsa_key_size = 256
$ed25519_key_size = 256

case $operatingsystem {
	'FreeBSD' :
		{	$config = 'ssh/FreeBSD_sshd.conf.erb'
			$groupowner = 'wheel'
			$package_name = 'BUILTIN'
			$service_name = 'sshd'

		}
	'Default' : 
		{
		       $config = 'ssh/default_sshd.conf.erb'
                        $groupowner = 'root'
                        $package_name = 'openssh-server'
                        $service_name = 'sshd'
		 }
}

}
