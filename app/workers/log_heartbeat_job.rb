class LogHeartbeatJob
  include Sidekiq::Worker

  def perform
    Rails.logger.info "[CRON] Heartbeat at #{Time.current}"
  end
end