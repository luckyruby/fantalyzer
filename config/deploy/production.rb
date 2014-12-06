set :stage, :production
set :rails_env, 'production'

server 'fantasy.luckyruby.com', roles: %w{web app db}, user: 'deployer'
