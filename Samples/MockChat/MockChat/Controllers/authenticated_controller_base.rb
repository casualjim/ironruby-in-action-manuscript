require 'application_controller'

class AuthenticatedControllerBase
  filter AuthorizeAttributed

  before_action :controller do |context|
    raise System::InvalidOperationException("Windows authentication is not supported.") if context.http_context.user.identity.is_a?(System::Security::Principal)
  end
  
end