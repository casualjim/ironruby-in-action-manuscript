# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  layout 'default'
  
  include AuthenticatedSystem
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'cf373e799ac52ae326196fc3fcf98d6d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  def conditions
#    params.symbolize_keys!
    result = params.reject {|k, v| [:controller, :action, :format].include? k.to_sym }
    result.symbolize_keys!
    since = headers['If-Modified-Since']||result[:since]
    result[:since] = Time.parse(since) unless since.nil?
    result
  end

end
