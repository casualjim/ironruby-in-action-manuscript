class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :description, :default => '', :limit => 140
  	  t.integer :favourites_count, :default => 0, :null => false
  	  t.integer :followers_count, :default => 0, :null => false
  	  t.boolean :following, :default => false
  	  t.integer :friends_count, :default => 0, :null => false
  	  t.string  :location, :limit => 140, :default => ''
  	  t.string  :name, :limit => 140, :null => false
  	  t.string  :profile_image_url, :limit => 500
  	  t.boolean :protected, :default => false
  	  t.integer :statuses_count, :default => 0, :null => false
  	  t.integer :screen_name, :limit => 140, :null => false
  	  t.string  :time_zone, :limit => 140
  	  t.string  :url, :limit => 500
  	  t.string  :utc_offset, :limit => 50
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
