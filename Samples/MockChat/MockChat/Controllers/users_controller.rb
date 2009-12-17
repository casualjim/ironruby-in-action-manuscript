require 'authenticated_controller_base'

class UsersController < AuthenticatedControllerBase

  def index
    @users = user_service.get_all
    view '', 'layout'
  end

  def new
    @user = User.new
    view 'new', 'layout'
  end

  def create
    @user = User.new
    save_user :new
  end

  def edit
	  @params_id = params[:id]
    @user = user_service.get_one params[:id].to_i
    view 'edit', 'layout'
  end

  def update
    @user = user_service.get_one params[:id].to_i
    save_user :edit
  end

  def destroy
    user_service.remove params[:id].to_i
    redirect_to_action 'index'
  end

  private

    def save_user(act)
      self.method(:update_model).of(User).call(@user, "user")

      if @user.is_valid
        user_service.save @user
        redirect_to_action('index', 'users')
      else
        collect_errors @user
        view act.to_s, 'layout'
      end
    end

end