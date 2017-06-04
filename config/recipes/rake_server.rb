# Para poder ejecutar tareas y comandos en el servidor remoto
# href: http://jessewolgamott.com/blog/2012/09/10/the-one-where-you-run-rake-commands-with-capistrano/
namespace :rake_server do
  desc "Run a task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    run("cd #{deploy_to}/current && bundle exec rake #{ENV['task']}")
  end
end
