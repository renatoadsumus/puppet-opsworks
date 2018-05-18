class docker::install_compose {

	$test_se_docker_nao_esta_instalado = 'ls /usr/local/bin/docker-compose'
	$proxy = "http://infoprx3.ogmaster.local:8080"

	exec{'instalando':
		command => "curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose",
		user	=> 'root',
		path => '/usr/bin',
		unless => $test_se_docker_nao_esta_instalado,
	}

	file { "/usr/bin/docker-compose":
		owner => 'root',
		group => 'root',
		require  =>  [Exec["instalando"]],
		mode  => '0755',
	}

}

#docker-compose --version