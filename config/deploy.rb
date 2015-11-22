set :application, 'fantalyzer'
set :repo_url, "ssh://git@github.com/luckyruby/fantalyzer.git"
set :deploy_to, "/var/www/fantalyzer"
set :scm, :git
set :linked_files, %w{config/database.yml config/secrets.yml config/config.yml}
set :linked_dirs, %w{log tmp}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Seed database'
  task :seed do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Load Players'
  task :load_players do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'load_players'
        end
      end
    end
  end

  desc 'Update Statistics'
  task :update_statistics do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'update_statistics'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
