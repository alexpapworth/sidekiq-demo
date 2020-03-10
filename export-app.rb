require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis:",
    namespace: "sidekiq:analysis-export",
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis:",
    namespace: "sidekiq:analysis-export",
  }
end

class RunExport
  include Sidekiq::Worker

  def perform(bulk_data_exports_ids)
    puts "got told to perform export for these ids #{bulk_data_exports_ids}"
  end
end

class UpdateAnalysisApp
  include Sidekiq::Worker

  sidekiq_options retry: 0 # `false` means don't put in dead set
end
