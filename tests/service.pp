#Tests moving the init script to a startup location
class gitlab::service inherits gitlab {


 ## Final Checks
 #---------------------------------------------------

  #sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production
  exec { 'gitlab basic check':
    path    => '/usr/bin:/usr/local:/usr/local/bin',
    cwd     => "${gitlab::params::git_home}/gitlab",
    user    => "${gitlab::params::git_user}",
    command => "bundle exec rake gitlab:env:info RAILS_ENV=production > ${gitlab::params::git_home}/bundle-exec-rake-output-basic.txt", 
  }
  
  
  #sudo -u git -H bundle exec rake gitlab:check RAILS_ENV=production (make sure gitlab is running)
    exec { 'gitlab advanced check':
    path    => '/usr/bin:/usr/local:/usr/local/bin',
    cwd     => "${gitlab::params::git_home}/gitlab",
    user    => "${gitlab::params::git_user}",
    command => "bundle exec rake gitlab:check RAILS_ENV=production > ${gitlab::params::git_home}/bundle-exec-rake-output-advanced.txt", 
    #TODO: Figure out why email is git@ac and not the value specified in the git_email variable, causes the check to fail
  }
  
  
  ## gitlab service
  #-------------------------------------------------------------------
  
  #init script
  file { '/etc/init.d/gitlab':
    ensure    => file,
    content  => template('gitlab/gitlab.init.6.0.erb'), 
    owner     => root,
    group     => root,
    mode      => '0755',
  }
  
}#end service
  