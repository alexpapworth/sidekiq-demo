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
  sidekiq_options retry: 0 # `false` means don't put in dead set
end

class UpdateAnalysisApp
  include Sidekiq::Worker
  
  def perform(bulk_data_exports_id)
    puts "got message to say export was complete for #{bulk_data_exports_id}"
  end
end
