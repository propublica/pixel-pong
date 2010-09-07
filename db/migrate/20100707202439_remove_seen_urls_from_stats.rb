class RemoveSeenUrlsFromStats < ActiveRecord::Migration
  def self.up
    remove_column(:stats, :seen_urls)
  end

  def self.down
    add_column(:stats, :seen_urls, :string)
  end
end
