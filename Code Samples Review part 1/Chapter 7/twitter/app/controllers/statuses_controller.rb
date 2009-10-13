class StatusesController < ApplicationController
  before_filter :login_required, :only => [:friends_timeline, :user_timeline, :replies, :update]
  
  # GET /statuses
  # GET /statuses.json
  # GET /statuses.xml
  def index
    @statuses = Status.find(:all)

    render_for_api(@statuses)
  end

  # GET /statuses/1
  # GET /statuses/1.json
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])

    render_for_api(@status)
  end

  # GET /statuses/friends_timeline
  # GET /statuses/friends_timeline.json
  # GET /statuses/friends_timeline.xml
  def friends_timeline
    @status = Status.new
    @user = current_user
    opts = conditions
    opts[:user_id] = @user.id
    @statuses = Status.timeline_with_friends_for opts 
    render_for_api(@statuses)
  end

  # GET /statuses/public_timeline
  # GET /statuses/public_timeline.json
  # GET /statuses/public_timeline.xml
  def public_timeline
    @statuses = Status.public_timeline
    render_for_api(@statuses)
  end

  # GET /statuses/user_timeline
  # GET /statuses/user_timeline.json
  # GET /statuses/user_timeline.xml
  def user_timeline
    @status = Status.new
    opts = conditions
    opts[:user_id] = requested_user.id             
    @statuses = Status.timeline_for(opts)
#    @statuses = requested_user.id == current_user.id ? Status.timeline_for(opts) : Status.timeline_with_friends_for(opts)
    render_for_api(@statuses)
  end

  # GET /statuses/replies
  # GET /statuses/replies.json
  # GET /statuses/replies.xml
  def replies
    @status = Status.new
    @user = current_user
    opts = conditions
    opts[:user_id] = @user.id
    @statuses = Status.replies_for(opts)
    render_for_api(@statuses)
  end

  # GET /statuses/friends
  # GET /statuses/friends.json
  # GET /statuses/friends.xml
  def friends
    requested_user
    logger.info "user: #@user"
    following = @user.following
    logger.info "returned following: #{following}"
    paged = following.paged(conditions)
    logger.info "returned paged following: #{paged}"
    @users = paged
    render_user_for_api(@users)
  end

  # GET /statuses/followers
  # GET /statuses/followers.json
  # GET /statuses/followers.xml
  def followers
    requested_user
    @users = @user.followers.paged(conditions)
    render_user_for_api(@users)
  end

  # GET /statuses/new
  # GET /statuses/new.json
  # GET /statuses/new.xml
  def new
    @status = Status.new
    render_for_api(@status)
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.json
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])
    @status.user = current_user

    respond_to do |format|
      if @status.save
        flash[:notice] = 'Status was successfully created.'
        format.html { redirect_to(@status) }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
        format.json { render :json => @status, :status => :created, :location => @status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.json
  # PUT /statuses/1.xml
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        flash[:notice] = 'Status was successfully updated.'
        format.html { redirect_to(@status) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.json  { render :json => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end

  private

    def render_for_api(param)
      respond_to do |format|
        format.html
        format.xml { render :xml => param.to_xml(Status.default_serialization_options) }
        format.json { render :json => param.to_json(Status.default_serialization_options) }
      end
    end

    def render_user_for_api(param)
      respond_to do |format|
        format.html
        format.xml { render :xml => param.to_xml(User.default_serialization_options) }
        format.json { render :json => param.to_json(User.default_serialization_options) }
      end
    end

    def requested_user
      @user = current_user
      logger.info "user ==== #@user"
      @user = User.find_by_id_or_login(params[:id]) unless params[:id].nil?
      @user
    end
end
