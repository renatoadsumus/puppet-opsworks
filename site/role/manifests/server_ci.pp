class role {
  include profile::base   
}

class role::server_ci::onpremise inherits role {
		#include infra::usuario_grupo_jenkins		
        #include jenkins::install_jenkins_master
		#include jenkins::install_plugin
		#include jenkins::configuracao.*
		#include jenkins::install_jenkins_slave
		#include jenkins::install_jenkins_slave
}
