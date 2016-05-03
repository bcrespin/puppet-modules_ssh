class ssh::install inherits ssh {

if $package_name != 'BUILTIN' {
	 package { '$package_name' :
		ensure => installed,
		name => $package_name,
	}
}

}
