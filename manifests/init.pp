# Basic SSH module
#
#
class ssh (
	$config = $ssh::params::config,
	$groupowner = $ssh::params::groupownergroupowner,
	$package_name = $ssh::params::package_name,
	$service_name = $ssh::params::service_name,

) inherits ssh::params	 {

# ensure $rsa_key_size,$ecdsa_key_size,$ed25519_key_size match required value
$curve_key = ["256","384","512"]
if $curve_key.include?($ecdsa_key_size)
{
	fail("ecdsa_key_size or ed25519_key_size variable  has bad value")
}

if ($rsa_key_size  != 1024 || $rsa_key_size != 2048 || $rsa_key_size != 4096 )
{
	fail("rsa_key_size has to be 1024 or 2048 or 4096")
}

	anchor { 'ssh::begin' : } ->
	class { 'ssh::install' : } ->
	class { 'ssh::config' : } ->
	class { 'ssh::service' : } ->
	anchor { 'ssh::end' : }
}
