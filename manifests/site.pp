
node 'infodevops2.ogmaster.local' {
        include infra::remover_proxy
		include infra::grupo_docker
        include infra::usuario_tfsservice_grupo_suporte
		include infra::usuario_grupo_jenkins
        include infra::pacotes_basicos
        include java::java8    
        include scm::install_svn
        include scm::install_git		
###### NECESSARIO EXECUTAR O JENKINS PRIMEIRO, POIS O GO CD PEGA UID GID DO JENKINS		
        include jenkins::install_jenkins_slave
        include docker::install
        include docker::install_compose
        include gocd::install_go_agent
        include gocd::install_go_agent_2
		include gocd::install_go_agent_3
        include elk::install_filebeat
        include s2i::install
        #include maven
		
}
node 'infodevops1.ogmaster.local' {
		#include infra::grupo_docker
		#include infra::usuario_tfsservice_grupo_suporte
		#include infra::usuario_grupo_jenkins
		#include java::java8
		#include scm::install_svn
		#include scm::install_git
        #include jenkins::install_jenkins_master
		#include jenkins::install_plugin
		#include jenkins::configuracao.*
		#include jenkins::install_jenkins_slave
		#include jenkins::install_jenkins_slave
		#include docker::install
        #include docker::install_compose
		
}

node 'infodevops3.ogmaster.local' {

	include role::server_ci_cd_onpremise

}

