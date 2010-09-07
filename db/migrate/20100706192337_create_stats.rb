class CreateStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      t.date    :date_for
      t.integer :hits
      t.string  :url
      t.string  :seen_urls
      t.string  :title
      t.timestamps
    end
  end

  def self.down
    drop_table :stats
  end
end
