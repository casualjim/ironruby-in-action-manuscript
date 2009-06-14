include System::Web::Security

class FormsAuthenticationService
  def sign_in(user_name, create_persistent_cookie)
    FormsAuthentication.set_auth_cookie user_name, create_persistent_cookie
  end 
  
  def sign_out
    FormsAuthentication.sign_out
  end
	
	
end

