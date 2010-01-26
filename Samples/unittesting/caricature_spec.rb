require 'rubygems' unless defined? Gem
require 'spec'
require 'caricature'

class CookieJar
  def swipe_cookie
    # complex logic here that swipes a cookie
  end
end

Spec::Runner.configure do |config|
  config.mock_with Caricature::RSpecAdapter
  config.include Caricature::RSpecMatchers
end

describe "Mocking" do
  it "should be caught" do
    cookie_jar = isolate CookieJar
    msg = "Caught with your fingers in the cookie jar"
    
    cookie_jar.when_receiving(:swipe_cookie).return(msg)  
    cookie_jar.swipe_cookie.should == msg
    cookie_jar.should have_received(:swipe_cookie)
  end
  
  it "should pass" do
    cookie_jar = isolate CookieJar
    msg = "Caught with your fingers in the cookie jar"
    cookie_jar.when_receiving(:swipe_cookie).return(msg)  
  end
  
  it "should fail" do
    cookie_jar = isolate CookieJar
    msg = "Caught with your fingers in the cookie jar"
    cookie_jar.when_receiving(:swipe_cookie).return(msg)  
    cookie_jar.should have_received(:swipe_cookie)
    
    # 'Mocking should fail' FAILED
    # expected #<CookieJar541...:0x00000100f40f78> to have received swipe_cookie
    # Couldn't find a method call with name swipe_cookie
  end
end
