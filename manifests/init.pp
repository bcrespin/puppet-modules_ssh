# Basic SSH module
#
#
class ssh (
	$config = $ssh::params::config,
	$groupowner = $ssh::params::groupownergroupowner,
	$package_name = $ssh::params::package_name,
	$service_name = $ssh::params::service_name

) inherits ssh:params	 {

	anchor { 'ssh::begin' : } ->
	class { 'ssh::install' : } ->
	class { 'ssh::config' : } ->
	class { 'ssh::service' : } ->
	anchor { 'ssh::end' : }
}
