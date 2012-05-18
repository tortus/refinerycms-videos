module Refinery
  module Videos
    class Video < Refinery::Core::BaseModel
      extend FriendlyId
      self.table_name = 'refinery_videos'

      attr_accessible :title, :date, :description, :video_url, :hidden, :position

      friendly_id :title, :use => [:slugged]
      acts_as_indexed :fields => [:title, :description, :video_url]

      validates :title, :presence => true, :uniqueness => true
    end
  end
end
