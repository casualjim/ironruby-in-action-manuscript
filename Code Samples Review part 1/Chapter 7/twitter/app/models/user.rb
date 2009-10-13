require 'digest/sha1'

module PagedFindExtension
  def paged(options)
    offset = (((options[:page]||1).to_i - 1) * 100)
    find :all, :limit => 100, :offset => offset
  end
end

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  
  has_many :statuses, :order => Status::DEFAULT_SORT, :after_add => :increment_status_count
  has_one :status, :order => Status::DEFAULT_SORT

  has_and_belongs_to_many :followers, :join_table => "follower_users",
                                      :association_foreign_key => :follower_id,
                                      :foreign_key => :user_id,
                                      :class_name => "User",
                                      :extend => PagedFindExtension,
                                      :after_add => :increment_followers_count
  
  has_and_belongs_to_many :following, :join_table => "follower_users",
                                      :association_foreign_key => :user_id,
                                      :foreign_key => :follower_id,
                                      :class_name => "User",
                                      :extend => PagedFindExtension,
                                      :after_add => :increment_friends_count


  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :profile_image_url,
                  :description, :location, :protected, :time_zone, :url, :utc_offset


  class << self
    # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
    #
    # uff.  this is really an authorization, not authentication routine.
    # We really need a Dispatch Chain here or something.
    # This will also let us return a human error message.
    #
    def authenticate(login, password)
      return nil if login.blank? || password.blank?
      u = find_by_login(login) # need to get the salt
      u && u.authenticated?(password) ? u : nil
    end

    def find_by_id_or_login(login)
      find(:first, :conditions => ["id = '#{login}' OR login = '#{login}'" ])
    end

    def default_serialization_options
      { :include => [:status] }   
    end

  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def before_create
    write_attribute :favourites_count, 0
    write_attribute :followers_count, 0
    write_attribute :friends_count, 0
    write_attribute :users_count, 0
  end

  def friends_timeline
    Status.timeline_with_friends_for :user_id => self.id
  end

  def timeline
    Status.timeline_for :user_id => self.id 
  end

  

end
