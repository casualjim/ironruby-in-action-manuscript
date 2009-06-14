require 'lightspeed_support'
require 'lightspeed_filter'
require 'user_service'

class ApplicationController < Controller

  filter HandleErrorAttribute
  filter LightspeedFilter

  include Lightspeed

  def current_user
    user_service.get_one_by_username user.identity.name
  end

  
end