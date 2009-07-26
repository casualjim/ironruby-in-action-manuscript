require File.dirname(__FILE__) + '/mvc_application'
require 'lightspeed_support'
require 'mock_chat_repository'
require 'user_service'
require 'chat_service'

class Object

  class << self

    def create_from_hash(options)
      result = self.new
      result.populate_from_hash options
      result
    end

  end

  def populate_from_hash(options)
    options.each do |k, v|
      mn = "#{k}=".to_sym
      self.send(mn, v) if self.respond_to?(mn)
    end
  end
end

def create_uow
  scope = SimpleUnitOfWorkScope.of(MockChatUnitOfWork).new($context)
  uow = scope.current
end

