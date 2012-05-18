module Refinery
  module Videos
    include ActiveSupport::Configurable
    
    config_accessor :embed_width, :embed_height
    
    self.embed_width = 720
    self.embed_height = 480
  end
end
