class AddColumnsToUser < ActiveRecord::Migration
  def self.up
      add_column :users, :description, :string, :default => '', :limit => 140
      add_column :users, :favourites_count, :integer, :default => 0, :null => false
      add_column :users, :followers_count, :integer, :default => 0, :null => false
      add_column :users, :following, :boolean, :default => false
      add_column :users, :friends_count, :integer, :default => 0, :null => false
      add_column :users, :location, :string, :limit => 140, :default => ''
      add_column :users, :profile_image_url, :string, :limit => 500
      add_column :users, :protected, :boolean, :default => false
      add_column :users, :users_count, :integer, :default => 0, :null => false
      add_column :users, :time_zone, :string, :limit => 140
      add_column :users, :url, :string, :limit => 500
      add_column :users, :utc_offset, :string, :limit => 50
  end

  def self.down
    remove_column :users, :description
    remove_column :users, :favourites_count
    remove_column :users, :followers_count
    remove_column :users, :following
    remove_column :users, :friends_count
    remove_column :users, :location
    remove_column :users, :profile_image_url
    remove_column :users, :protected
    remove_column :users, :users_count
    remove_column :users, :time_zone
    remove_column :users, :url
    remove_column :users, :utc_offset
  end
end
