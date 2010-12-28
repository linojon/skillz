# automatically run bundler in server
require "bundler/capistrano"

set :user, 'railsdeploy'
set :application, "skillz"
set :domain, "173.255.230.204"  # "www.skillzillion.com"
set :port, '5050'

set :scm, :git
set :repository, "git@github.com:linoj/skillz.git" # "git://github.com/linoj/skillz.git"


# ref: http://epochwolf.com/capistrano-use-git-repository-on-the-same-ser
# http://stackoverflow.com/questions/2293212/capistrano-git-repository-local-to-production-server
#set :repository, "file:///srv/git/myapp.git" #or "/home/#{user}/path/to/repo.git"
#set :local_repository, "file://." #or "nameOfHostFromSSHConfig:/srv/git/myapp.git"
#remove the deploy_via copy line as well.

set :deploy_via, :remote_cache
#set :git_shallow_clone, 1

set :scm_username, 'linoj'
#set :scm_password, 'jonathan'
ssh_options[:forward_agent] = true

set :branch, :master
default_run_options[:pty] = true

set :use_sudo, false
set :keep_releases, 5

set :deploy_to, "/home/#{user}/apps/#{application}"
set :group_writable, false

# http://blog.josephholsten.com/2010/09/deploying-with-bundler-and-capistrano/
set :bundle_without, [:development, :test, :cucumber]

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
