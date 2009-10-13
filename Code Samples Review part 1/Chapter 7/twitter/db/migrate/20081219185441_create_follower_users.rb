class CreateFollowerUsers < ActiveRecord::Migration
  def self.up
    create_table :follower_users, :id => false do |t|
          t.integer :user_id
          t.integer :follower_id
    
      t.timestamps
    end
    add_index :follower_users, [:user_id]
    add_index :follower_users, [:follower_id]

  end

  def self.down
    drop_table :follower_users
  end
end
