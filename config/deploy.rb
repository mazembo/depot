set :ip, "74.63.10.91"
set :user, "root"
set :server_name, "dielais.com"

set :application, "dielais"
set :scm, :git

set :repository, "git://github.com/mazembo/depot.git"

set :deploy_to, "/home/admin/#{application}"

set :use_sudo, false
set :group_writable, false


set :branch, 'master'

set :deploy_via, :checkout

default_run_options[:pty] = true

set :rails_env, "production"

role :app, server_name
role :web, server_name
role :db, server_name, :primary => true

task :after_update_code, :roles => [:web, :db, :app] do
run "chmod 755 #{release_path}/public"
run "chown admin:admin #{release_path}/public -R"

namespace :deploy do
desc "cold deploy"
task :cold do
update
passenger::restart
end

desc "restart passenger"
task :restart do
passenger::restart
end
end

namespace :passenger do
desc "Restart Application"
task :restart do
run "touch #{current_path}/tmp/restart.txt"
end

end
end