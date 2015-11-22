set :stage, :production
set :rails_env, 'production'
set :branch, ENV['branch'] || "master"
set :puma_state, "#{shared_path}/tmp/puma/state"
set :puma_pid, "#{shared_path}/tmp/puma/pid"

server 'fantasy.luckyruby.com', roles: %w{web app db}, user: 'klin'
