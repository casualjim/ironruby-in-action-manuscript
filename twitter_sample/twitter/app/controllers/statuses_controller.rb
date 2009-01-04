class StatusesController < ApplicationController
  before_filter :login_required, :only => [:friends_timeline]
  
  # GET /statuses
  # GET /statuses.xml
  def index
    @statuses = Status.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])

    render_for_api(@status)
  end
  
  def friends_timeline
    @status = Status.new
    params[:user_id] = current_user.id
    @statuses = Status.timeline_with_friends_for params 
    render_for_api(@statuses)
  end

  def public_timeline
    @statuses = Status.public_timeline
    render_for_api(@statuses)
  end

  def user_timeline
    @status = Status.new
    params[:user_id] = requested_user.id
    @statuses = Status.timeline_for params
    render_for_api(@statuses)
  end

  def replies
    @status = Status.new
    params[:user_id] = current_user.id
    @statuses = Status.replies_for(params)
    render_for_api(@statuses)
  end

  def friends
    requested_user
    @users = @user.following.paged(params)
    render_user_for_api(@users)
  end

  def followers
    requested_user
    @users = @user.followers.paged(params)
    render_user_for_api(@users)
  end

  # GET /statuses/new
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
      @user = User.find_by_id_or_login(params[:id]) unless params[:id].nil?
      @user
    end
end
