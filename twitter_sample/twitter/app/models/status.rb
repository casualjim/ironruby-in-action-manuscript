class Status < ActiveRecord::Base
  validates_presence_of :text
  validates_presence_of :user_id
    
  validates_format_of :source_url, 
                      :with => /^https?:\/\/([a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+)+(\/*[A-Za-z0-9\/-_&:?+=\/\/.%]*)*/i, 
                      :allow_nil => true, 
                      :allow_blank => true
  
  belongs_to :user                  
  belongs_to :in_reply_to_user, :class_name => "User", :foreign_key => "in_reply_to_user_id"
  belongs_to :in_reply_to_status, :class_name => "Status", :foreign_key => "in_reply_to_status_id"
  has_many :replies, :class_name => "Status", :foreign_key => "in_reply_to_status_id"
  
  class << self
    
    def timeline_with_friends_for(user)
      find :all, :conditions => ["user_id = '#{user.id}' or user_id in (select user_id from follower_users where follower_id = '#{user.id}')"],
                 :order => "created_at DESC"
    end
    
  end
end
