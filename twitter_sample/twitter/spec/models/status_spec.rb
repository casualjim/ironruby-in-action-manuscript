require File.dirname(__FILE__) + '/../spec_helper'

context "Status class with fixtures loaded\n" do
  # fixtures :users, :statuses
  fixtures :users, :follower_users, :statuses

  specify "should count six Statuses" do
    Status.count.should == 6
  end

  # describe Status do
    
    before(:each) do
      @status = Status.new
    end
    
    context 'for persistence it' do
    
      specify "should create a status" do
        status = create_status
        violated "#{create_status.errors.full_messages.to_sentence}" if status.new_record?
      end
    
      
      specify "should not create an empty instance" do
        @status.should_not be_valid
        
      end
      
      specify "user_id cannot be nil" do
        lambda do
          status = create_status(:user_id => nil)
          status.errors.on(:user_id).should_not be_nil      
        end.should_not change(Status, :count)
      end

      specify "should have a text" do
        lambda do
          status = create_status(:text => nil)
          status.errors.on(:text).should_not be_nil      
        end.should_not change(Status, :count)
      end

      specify "source_url can be blank" do
        lambda do
          status = create_status(:source_url => "")
          violated "#{status.errors.full_messages.to_sentence}" if status.new_record?      
        end.should change(Status, :count)
      end
      
      specify "source_url can be nil" do
        lambda do
          status = create_status(:source_url => nil)
          violated "#{status.errors.full_messages.to_sentence}" if status.new_record?   
        end.should change(Status, :count)
      end
    
      specify "should be a valid url when source_url is not blank or nil" do
        lambda do
          status = create_status(:source_url => "htt://dld.")
          status.errors.on(:source_url).should_not be_nil      
        end.should_not change(Status, :count)
      end
        
        
    end
      
    
    context "as relations it" do
      
      specify "should have a user which is the author" do
        status = statuses(:first)
        status.should_not be_nil
        status.user.should_not be_nil
        status.user.id.should == 1
      end
      
      specify "can have a user to which this status is a reply" do
        status = statuses(:fourth)
        status.should_not be_nil
        status.in_reply_to_user.should_not be_nil
        status.in_reply_to_user.id.should == 2
      end
      
      specify "can have a status to which this can be a reply" do
        status = statuses(:third)
        status.should_not be_nil
        status.in_reply_to_status_id.should == 2
        status.in_reply_to_status.should_not be_nil
        status.in_reply_to_status.id.should == 2
      end
    end
    
    context "finders" do
      
      specify "find all the statuses for a user including his friends" do
        result = Status.timeline_with_friends_for users(:aaron)
        result.should_not be_empty
        result.length.should == 5
      end
      
    end
  # end
   
  protected
    def create_status(options={})
     Status.create({ 
        :source => "ironruby in action",
        :source_url => "http://manning.com/carrero",
        :text => "the random status description",
        :user_id => 1
      }.merge(options))
    end
end
