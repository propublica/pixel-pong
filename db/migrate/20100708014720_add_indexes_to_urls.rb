class AddIndexesToUrls < ActiveRecord::Migration
  def self.up
    add_index(:stats, [:url])
  end

  def self.down
    remove_index(:stats, :index_stats_on_url)
  end
end
