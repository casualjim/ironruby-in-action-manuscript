require 'rubygems' unless defined? Gem
require 'spec'

class CookieJar
  def swipe_cookie
    # complex logic here that swipes a cookie
  end
end

describe "Mocking with RSpec" do
  it "should be caught" do
    cookie_jar = mock(CookieJar.new)
    msg = "Caught with your fingers in the cookie jar"
    cookie_jar.should_receive(:swipe_cookie) { msg  }  # Gets autoverified at test teardown. 

    cookie_jar.swipe_cookie.should == msg
  end
  
  it "should fail" do
    cookie_jar = mock(CookieJar.new)
    msg = "Caught with your fingers in the cookie jar"
    cookie_jar.should_receive(:swipe_cookie) { msg  }  # Gets autoverified at test teardown. 
    
    # Spec::Mocks::MockExpectationError in 'Mocking should fail'
    # Mock #<CookieJar:0x00000101396f90> expected :swipe_cookie with (any args) once, but received it 0 times
  end
end
