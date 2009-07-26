require 'lightspeed_support'
require 'lightspeed_filter'
require 'user_service'

class ApplicationController < Controller

  filter HandleErrorAttribute
  filter LightspeedFilter

  include Lightspeed::ControllerHelpers

  attr_accessor :user_service

  def user_service
    @user_service ||= UserService.new(uow_scope)
  end

  def current_user
    return nil unless is_authenticated?
    user_service.get_one_by_username user.identity.name
  end

  def is_authenticated?
    user.identity.is_authenticated
  end

  
end