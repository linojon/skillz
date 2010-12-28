load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks

after "deploy:update_code", :roles => [:web, :db, :app] do
  run "chown -R #{user}:#{user} /home/#{user}/apps/#{application}" 
  run "chmod 755 #{release_path}/public -R" 
  
  run "cd #{release_path}/app/controllers && cp -f application_controller.rb application.rb" # Passenger 3 kludge
  run "cd #{release_path}/config         && cp -f deploy.database.yml database.yml"
  run "cd #{release_path}/config         && cp -f deploy.environment.rb environment.rb"
  run "cd #{release_path}/public         && cp -f deploy.htaccess .htaccess && chmod 644 .htaccess"
  run "rm /home/#{user}/public_html"
  run "ln -s #{release_path}/public /home/#{user}/public_html"
end

after "deploy:update", "deploy:cleanup" 

namespace :deploy do
  desc "cold deploy" 
  task :cold do
    update
    passenger::restart
  end

  desc "Restart Passenger" 
  task :restart do
    passenger::restart
  end
end

namespace :passenger do
  desc "Restart Passenger" 
  task :restart do
    run "cd #{current_path} && touch tmp/restart.txt" 
  end
end
