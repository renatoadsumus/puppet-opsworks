class role {
  include profile::base   
}

class role::agent_ci_cd inherits role {

include profile::slave_ci
include profile::agent_cd

}

class role::agent_ci_cd::onpremise::install inherits role::agent_ci_cd{

$user = 'tfsservice'
$group = 'suporte'

include profile::install_agent_cd_onpremise
#include profile::install_agent_ci_onpremise

}

class role::agent_ci_cd::onpremise::run inherits role::agent_ci_cd{		
 
#include profile::run_agent_cd_onpremise
#include profile::run_agent_ci_onpremise
}
