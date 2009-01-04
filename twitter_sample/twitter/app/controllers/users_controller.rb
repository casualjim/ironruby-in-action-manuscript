class UsersController < ApplicationController
  before_filter :requested_user, :only => [:show]
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def show
    logger.debug("In show method")
    respond_to do |format|
      format.html
      format.xml { render :xml => @user.to_xml(User.default_serialization_options) }
      format.json { render :json => @user.to_json(User.default_serialization_options) }
    end
  end

  private

    def requested_user
      @user = current_user
      @user = User.find_by_id_or_login(params[:id]) unless params[:id].nil?
      @user = User.find_by_email(params[:email]) unless params[:email].nil?
      @user
    end

end
#