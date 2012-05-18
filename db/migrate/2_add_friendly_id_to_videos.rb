class AddFriendlyIdToVideos < ActiveRecord::Migration

  def self.up
    change_table :refinery_videos do |t|
      t.string :slug
      t.index :slug, :unique => true
    end
    ::Refinery::Videos::Video.all.map(&:save)
  end
  
  def self.down
    change_table :refinery_videos do |t|
      t.remove_index :slug
      t.remove :slug
    end
  end

end
