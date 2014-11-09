require "bundler/capistrano"
require "rvm/capistrano"

load 'deploy/assets'

#set :rvm_ruby_string, '1.9.3'
#set :rvm_type, :user  # Don't use system-wide RVM

set :application, "gimme_oro"
set :repository,  "https://github.com/celsodantas/gimme_oro.git"
set :user, "deployer"
set :server_ip, "server.celsodantas.com"
set :deploy_to, "/home/#{user}/rails_apps/#{application}"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, server_ip                          # Your HTTP server, Apache/etc
role :app, server_ip                          # This may be the same as your `Web` server
role :db,  server_ip, :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true

after 'deploy:finalize_update', 'deploy:symlink_db'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end



namespace :deploy do

end
