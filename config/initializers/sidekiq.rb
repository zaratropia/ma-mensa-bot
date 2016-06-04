Sidekiq.configure_server do |config|
  config.redis = { url: 'unix://~/.redis/sock' }
end
