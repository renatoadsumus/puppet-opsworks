class role {  
  include java::java8
}

class role::server_ci_cd inherits role {

class {'profile::agent_cd':
                user_local => 'go',
				group_local => 'go',		
        }
		
include profile::server_cd

}

class role::server_ci_cd::onpremise::run inherits role::server_ci_cd {

include profile::run_server_cd_onpremise
include profile::run_agent_cd_onpremise

}

class role::server_ci_cd::aws::run inherits role::server_ci_cd {

include profile::run_server_cd_aws
#include profile::run_agent_cd_aws

}