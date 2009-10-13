class Status < ActiveRecord::Base

  DEFAULT_PAGESIZE = 20
  DEFAULT_SORT = "created_at DESC"

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


  def before_create
    if self.source.blank?
      self.source = 'web'
      self.source_url = ''
    end
  end

  class << self

    def timeline_with_friends_for(options={})
      options[:where] = "( user_id = :user_id or user_id in (select user_id from follower_users where follower_id = :user_id) )"
      find :all, extract_timeline_options(options)
    end

    def public_timeline
      find :all, :limit => DEFAULT_PAGESIZE, :order => DEFAULT_SORT, :include => [:user]
    end

    def timeline_for(options={})
      find :all, extract_timeline_options(options)
    end

    def replies_for(options={})
      options[:where] = "( text LIKE '@%' AND user_id = :user_id )"
      find :all, extract_timeline_options(options.reject {|k, v| k.to_sym == :count  })
    end

    def default_serialization_options
      { :include => [:user] }   
    end

    private

      def add_since_if_specified(whr, par, opts)
        if opts.respond_to?(:since)
          whr = whr.blank? ? "( created_at >= :since )" : "#{whr} AND ( created_at >= :since )"
          par[:since] = opts[:since].to_s(:db)
        end
      end

      def add_since_id_if_specified(whr, par, opts)
        if opts.respond_to?(:since_id)
          whr = whr.blank? ? "( id >= :since_id )" : "#{whr} AND ( id >= :since_id )"
          par[:since_id] = opts[:since_id]
        end
      end

      def build_conditions_from(opts)
        opts.symbolize_keys!
        whr = opts[:where]
        par = { :user_id => opts[:user_id] }
        add_since_if_specified whr, par, opts
        add_since_id_if_specified whr, par, opts
        [whr, par]
      end

      def extract_timeline_options(options={})
        opts = { :where => "( user_id = :user_id )", :page => 1, :count => DEFAULT_PAGESIZE, :sort => DEFAULT_SORT }.merge(options)
        limit = opts[:count].to_i
        limit = 200 if limit > 200
        offset = (opts[:page].to_i - 1) * limit

        {
          :conditions => build_conditions_from(opts),
          :order => opts[:sort],
          :include => [:user],
          :limit => limit,
          :offset => offset
        }
      end


  end
end
