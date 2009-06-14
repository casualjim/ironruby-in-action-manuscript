require 'application_controller'
require 'user_service'
require 'forms_authentication_service'

include System::Web::Mvc

class AccountController < ApplicationController
  
  
  filter :change_password, AuthorizeAttribute
  
  before_action :controller do |context|
    raise System::InvalidOperationException("Windows authentication is not supported.") if context.http_context.user.identity.is_a?(System::Security::Principal)
  end
  
  accept_verbs :sign_on, :post
  
  attr_reader :forms_auth, :membership_service
  
  def initialize(forms_auth_svc=nil, membership_svc=nil)
    @forms_auth = forms_auth_svc||FormsAuthenticationService.new
    @membership_service = membership_svc||UserService.new(uow_scope)
  end
  
  def log_on
    view "", 'layout'
  end
  
  def sign_on

  end
  
  def log_off

  end
  
  def register

  end
  
  def change_password

  end
  
  private


end