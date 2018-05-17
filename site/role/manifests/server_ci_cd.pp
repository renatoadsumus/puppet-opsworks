class role {  
  include java::java8
}

class role::server_ci_cd inherits role {

include profile::server_cd
include profile::agent_cd

}

class role::server_ci_cd::onpremise inherits role::server_ci_cd {

include profile::run_server_cd_onpremise
#include profile::run_agent_cd_onpremise

}

class role::server_ci_cd::aws inherits role::server_ci_cd {

include profile::run_server_cd_aws
#include profile::run_agent_cd_aws

}