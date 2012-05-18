module Refinery
  module Videos
    class Video < Refinery::Core::BaseModel
      extend FriendlyId
      self.table_name = 'refinery_videos'

      attr_accessible :title, :date, :description, :video_url, :hidden, :position

      friendly_id :title, :use => [:slugged]
      acts_as_indexed :fields => [:title, :description, :video_url]

      validates :title, :presence => true, :uniqueness => true
      validates :video_url, :presence => true
      
      def path
        "Videos - #{title}"
      end
      
      def youtube_id
        if video_url =~ /\?v=([^&]+)/
          $1
        else
          video_url
        end
      end
      
      def embed_url
        "http://www.youtube.com/embed/#{youtube_id}"
      end
      
      def self.active; where(:hidden => false); end
      def self.live; active; end
      def self.by_position; order("position ASC"); end
      def self.by_date; order("date DESC"); end
      
      def self.featured
        active.by_position.first
      end
      
      after_create :move_to_top
      def move_to_top
        self.class.transaction do
          self.position = 1
          self.class.where("id != ? and position >= ?", self.id, self.position).
            update_all("position = position + 1")
          self.save!
        end
      end
      
    end
  end
end
