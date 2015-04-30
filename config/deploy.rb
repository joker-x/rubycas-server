set :application, "cas.podemos.info"
set :repository,  "https://github.com/joker-x/rubycas-server/"

set :deploy_to, "/var/www/cas.podemos.info"

set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "capistrano@rubycas-prod"                          # Your HTTP server, Apache/etc
role :app, "capistrano@rubycas-prod"                          # This may be the same as your `Web` server
role :db,  "capistrano@rubycas-prod", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
#

namespace :deploy do
  task :start, :roles => :app do
    run "sudo /etc/init.d/unicorn_cas start"
  end
  task :stop, :roles => :app do
    run "sudo /etc/init.d/unicorn_cas stop"
  end
  task :restart, :roles => :app do
    run "sudo /etc/init.d/unicorn_cas restart"
  end
end
