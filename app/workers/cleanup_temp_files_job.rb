class CleanupTempFilesJob
  include Sidekiq::Worker

  def perform
    Rails.logger.info "[CRON] Cleaning up temporary files..."
    # Your cleanup logic here
  end
end