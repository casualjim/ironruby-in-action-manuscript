require 'application_controller'
require 'user_service'

include System::Web::Mvc

class AccountController < ApplicationController

  filter :change_password, AuthorizeAttribute

  before_action :controller do |context|
    raise System::InvalidOperationException("Windows authentication is not supported.") if context.http_context.user.identity.is_a?(System::Security::Principal)
  end

  accept_verbs :sign_on, :post

  def log_on
    @return_url = ""
    @return_url = params[:ReturnUrl] if params.contains_key(:ReturnUrl)
    view "", 'layout'
  end

  def sign_on
    username = params[:username]
    return view('log_on', 'layout') unless validate_logon(username, params[:password])

    System::Web::Security::FormsAuthentication.set_auth_cookie(username, !!params[:remember_me])
    return redirect(params[:return_url]) if params.contains_key(:return_url)

    redirect_to_action 'index', 'home'
  end

  def log_off
    System::Web::Security::FormsAuthentication.sign_out
    redirect_to_action 'index', 'home'
  end

  def register
    @password_length = user_service.min_password_length
    @user = User.new
    if request.post?
      self.method(:update_model).of(User).call(@user, "user")

      if validate_matching_passwords(params[:"user.password"], params[:confirm_password]) and @user.is_valid
        user_service.save @user
        System::Web::Security::FormsAuthentication.set_auth_cookie @user.username, false
        return redirect_to_action('index', 'home')
      end
      collect_errors @user unless @user.is_valid
    end

    view '', 'layout'
  end

  def change_password
    @password_length = user_service.min_password_length
    if request.post? && validate_change_password(params[:currentPassword], params[:newPassword], params[:confirmPassword])
      begin
        unless user_service.change_password(user.identity.name, params[:newPassword], params[:confirmPassword])
          return redirect_to_action('change_password_success')
        end
        model_state.add_model_error "_FORM", "The current password is incorrect or the new password is invalid."
      rescue
        model_state.add_model_error "_FORM", "The current password is incorrect or the new password is invalid."
      end
    end
    view '', 'layout'
  end

  private

  def validate_logon(username, password)
    model_state.add_model_error("username", "You must specify a username.") if username.to_s.empty?
    model_state.add_model_error("password", "You must specify a password.") if password.to_s.empty?
    model_state.add_model_error("_FORM", "The username or password provided is incorrect") unless user_service.validate_user(username, password)

    return model_state.is_valid
  end

  def validate_change_password(current_password, new_password, confirm_password)
    model_state.add_model_error "currentPassword", "You must specify a current password." if current_password.to_s.empty?

    validate_matching_passwords new_password, confirm_password
  end

  def validate_matching_passwords(password, confirm_password)
    if password.nil? or password.to_s.size < user_service.min_password_length
      model_state.add_model_error "password", "You must specify a password of #{user_service.min_password_length} or more characters"
    end
    model_state.add_model_error("_FORM", "The password and confirmation password do not match") unless password == confirm_password

    return model_state.is_valid
  end

end