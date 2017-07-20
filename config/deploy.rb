# Obtenido de la guía de DigitalOcean para Ruby, Rails, Capistrano, Nginx, MYSQL y Puma sobre Ubuntu 14.04
# href: https://www.digitalocean.com/community/tutorials/deploying-a-rails-app-on-ubuntu-14-04-with-capistrano-nginx-and-puma
# config valid only for current version of Capistrano
lock "3.8.1"

# Change these
server "pfc-server", port: ENV['SERVER_PORT'], roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:xavilens/sam.git'
set :application,     'sam'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs,  %w{public/images}

load "config/recipes/rake_server.rb"

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  # Permite la carga del esquema en el servidor
  # href: https://gist.github.com/wacaw/657744af41dcf4963646
  desc "Load the initial schema - it will WIPE your database, use with care"
  task :db_schema_load do
    on roles(:db) do
      puts <<-EOF

      ************************** WARNING ***************************
      If you type [yes], rake db:schema:load will WIPE your database
      any other input will cancel the operation.
      **************************************************************

      EOF
      ask :answer, "Are you sure you want to WIPE your database?"
      if fetch(:answer) == 'yes'
        within release_path do
          with rails_env: :production do
            rake 'db:schema:load'
          end
        end
      else
        puts "Cancelled."
      end
    end
  end

  desc "Reset of the database."
  task :db_reset do
    on roles(:db) do
      puts <<-EOF

      ************************** WARNING ***************************
      If you type [yes], rake db:reset will WIPE your database
      any other input will cancel the operation.
      **************************************************************

      EOF
      ask :answer, "Are you sure you want to WIPE your database?"
      if fetch(:answer) == 'yes'
        within release_path do
          with rails_env: :production do
            rake 'db:reset'
          end
        end
      else
        puts "Cancelled."
      end
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
