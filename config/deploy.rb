# The host where people will access my site
set :application, "bacco"
set :user, "fabsn"
set :admin_login, "fabs"

set :repository, "svn://svn.linux.ime.usp.br/fabsn/bacco"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{admin_login}/#{application}"

# My DreamHost-assigned server
set :domain, "#{admin_login}@epistemol.net"
role :app, domain
role :web, domain
role :db,  domain, :primary => true

desc "Link shared files"
task :before_symlink do
  run "rm -drf #{release_path}/public/bin"
  run "ln -s #{shared_path}/bin #{release_path}/public/bin"
end

set :use_sudo, false
set :checkout, "export"

# I used the handy quick tool to set up an SVN repository on DreamHost and this is where it lives
set :svn, "/usr/bin/svn"
set :svn_user, 'fabsn'
set :svn_password, 'baccofabsn'
set :repository,
  Proc.new { "--username #{svn_user} " +
       "--password #{svn_password} " +
       "svn://svn.linux.ime.usp.br/fabsn/bacco" }

desc "Restarting after deployment"
task :after_deploy, :roles => [:app, :db, :web] do
  run "touch #{deploy_to}/current/public/dispatch.fcgi" 

  run "sed 's/# ENV\\[/ENV\\[/g' #{deploy_to}/current/config/environment.rb > #{deploy_to}/current/config/environment.temp"
  run "mv #{deploy_to}/current/config/environment.temp #{deploy_to}/current/config/environment.rb"
end

desc "Restarting after rollback"
task :after_rollback, :roles => [:app, :db, :web] do
  run "touch #{deploy_to}/current/public/dispatch.fcgi"
end

desc "restart override"
task :restart, :roles => :app do
  run "killall -9 ruby"
end

