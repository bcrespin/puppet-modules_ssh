# Basic SSH module
#
#
class ssh (
	$ecdsa_key_size = $ssh::params::ecdsa_key_size,
	$rsa_key_size = $ssh::params::rsa_key_size,
	$ed25519_key_size = $ssh::params::ed25519_key_size,
	$config = $ssh::params::config,
	$groupowner = $ssh::params::groupownergroupowner,
	$package_name = $ssh::params::package_name,
	$service_name = $ssh::params::service_name,
) inherits ssh::params	 {

# ensure $rsa_key_size,$ecdsa_key_size,$ed25519_key_size match required value
$curve_key = ['256','384','521']
$rsa_allowed_key = [ '1024' , '2048' , '4096']

if  ! ($ecdsa_key_size in $curve_key)
	{fail("ecdsa_key_size variable  has bad value") }
if  ! ($ed25519_key_size in $curve_key)
        {fail("ed25519_size variable  has bad value") }
if ! ($rsa_key_size in $rsa_allowed_key)
        {fail("rsa_key_size variable  has bad value") }

anchor { 'ssh::begin' : } ->
class { 'ssh::install' : } ->
class { 'ssh::config' : } ->
class { 'ssh::service' : } ->
anchor { 'ssh::end' : }
}
