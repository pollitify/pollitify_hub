require "sidekiq"
require "sidekiq-cron"

Rails.application.configure do
  config.active_job.queue_adapter = :sidekiq
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Sidekiq.configure_server do |config|
  schedule_file = Rails.root.join("config/schedule.yml")

  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end

  config.logger.formatter = proc do |severity, time, progname, msg|
    "[Sidekiq] #{time.strftime("%Y-%m-%d %H:%M:%S")} #{severity} -- #{msg}\n"
  end
end