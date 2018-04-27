class role::server_ci_cd_aws { 
  include profile::server_ci_cd_aws
  include profile::agent_gocd_aws
} 
