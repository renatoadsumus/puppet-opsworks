class profile::java8 {
	
	package{'java-1.8.0-openjdk-devel':
		ensure => present,
	} ->		
	file_line { "/etc/environment":	
		path => "/etc/environment",  			
		line => "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk",
		match => "^JAVA_HOME.*$",
	}
}
