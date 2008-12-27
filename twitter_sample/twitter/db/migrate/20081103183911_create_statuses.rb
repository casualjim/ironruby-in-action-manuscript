class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.boolean :favourited, :default => false
  	  t.integer :in_reply_to_status_id
  	  t.integer :in_reply_to_user_id
  	  t.string	:source, :limit => 50
  	  t.string	:source_url, :limit => 500
  	  t.text  	:text, :null => false
  	  t.boolean :truncated, :default => false
  	  t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
