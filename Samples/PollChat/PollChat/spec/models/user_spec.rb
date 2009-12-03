require File.join(File.dirname(__FILE__),"..", "spec_helper")

describe User do

  before(:each) do
    @user = User.new
  end

  [:name, :username, :email, :password, :salt].each do |nm|

    it "should have a #{nm} getter" do
      @user.should respond_to(nm)
    end

    it "should have a #{nm} setter" do
      @user.should respond_to("#{nm}=".to_sym)
    end

  end
end