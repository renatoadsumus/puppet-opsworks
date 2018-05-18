class elk::install_filebeat {
	$proxy = "http://infoprx3.ogmaster.local:8080"
	
	service{"filebeat":
		ensure   => running,
		enable   => true,
		require  => File["filebeat.yml"],
	}
	file{"filebeat.yml":
		ensure   => "file",
		path     => "/etc/filebeat/filebeat.yml",
		replace  => true,
		source   => "puppet:///modules/elk/filebeat.yml",
		require  => Package["filebeat"],
		notify   => Service["filebeat"],
	}
	package{"filebeat":
		ensure   => present,
		require  => Yumrepo["elastic-5.x"],
	}
	yumrepo{"elastic-5.x":
		ensure   => present,
		baseurl  => "https://artifacts.elastic.co/packages/5.x/yum",
		descr    => "Elastic repository for 5.x packages",
		gpgcheck => 1,
		gpgkey   => "https://artifacts.elastic.co/GPG-KEY-elasticsearch",
		enabled  => true,
		proxy    => "$proxy",
		require  => Exec["install_elk_gpg_key"],
	}
	exec{"install_elk_gpg_key":
		environment => ["http_proxy=$proxy", "https_proxy=$proxy",],
		command     => "/bin/rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch",
	}
}
