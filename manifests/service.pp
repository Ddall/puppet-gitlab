class gitlab::service inherits gitlab {
  
#TODO: run an if statement to choose the correct init script (gitlab.init.6-1.erb, ect..)
  #init script
  file { '/etc/init.d/gitlab':
    ensure    => file,
    content   => template('gitlab/init.6-1.erb'), #TODO make this point to a variable
    owner     => root,
    group     => root,
    mode      => '0755',
    before    => Service['gitlab'], #TODO, make this subscribe
  }
  
  #gitlab service
	service { 'gitlab' :
	  ensure    => running,
	  enable    => true,
	  hasrestart  => false,#Leave as false until fixed https://github.com/gitlabhq/gitlabhq/pull/5259
	  hasstatus   => true,  
	}

	service { 'nginx' :
	  ensure   => running,
	  enable   => true,    
	  hasrestart  => true,
    hasstatus   => true, 
	}
}