class role {
  include java::java8
}

class role::agent_ci inherits role {	
		
include profile::slave_ci

}

class role::agent_ci_cd::onpremise::install inherits role::agent_ci{

	class {' profile::agent_cd':
            user_local => 'tfsservice',
			group_local => 'suporte',		
    }		
		
include profile::install_agent_cd_onpremise
#include profile::install_agent_ci_onpremise

}

class role::agent_ci_cd::onpremise::run inherits role::agent_ci{	

include profile::agent_cd
include profile::run_agent_cd_onpremise
#include profile::run_agent_ci_onpremise
}
