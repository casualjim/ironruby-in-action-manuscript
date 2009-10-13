require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatusesController do

  fixtures :users, :follower_users, :statuses

  def mock_status(stubs={})
    @mock_status ||= mock_model(Status, stubs)
  end

  def user_mock(stubs={})
    @user_mock || mock_model(User, stubs)
  end

  describe "responding to GET index" do

    it "should expose all statuses as @statuses" do
      Status.should_receive(:find).with(:all).and_return([mock_status])
      get :index
      assigns[:statuses].should == [mock_status]
    end

    describe "with mime type of xml" do

      it "should render all statuses as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Status.should_receive(:find).with(:all).and_return(statuses = mock("Array of Statuses"))
        statuses.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end

    end

    describe "with mime type of json" do

      it "should render all statuses as json" do
        request.env["HTTP_ACCEPT"] = "application/json"
        Status.should_receive(:find).with(:all).and_return(statuses = mock("Array of Statuses"))
        expected = "Generated JSON"
        statuses.should_receive(:to_json).and_return(expected)
        get :index
        response.body.should == expected
      end

    end

  end

  describe "responding to GET friends_timeline" do

    before do
      login_as :quentin
      stub!(:reset_session)
    end

    it "should expose the resulting statuses as @statuses" do
      Status.should_receive(:timeline_with_friends_for).with("user_id" => 1).and_return([mock_status])
      get :friends_timeline
      assigns[:statuses].should == [mock_status]
    end

    describe "with mime type of xml" do

      it "should render the resulting statuses as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Status.should_receive(:timeline_with_friends_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
        statuses.should_receive(:to_xml).and_return("generated XML")
        get :friends_timeline
        response.body.should == "generated XML"
      end

    end

    describe "with mime type of json" do

      it "should render the resulting statuses as json" do
        request.env["HTTP_ACCEPT"] = "application/json"
        Status.should_receive(:timeline_with_friends_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
        expected = "Generated JSON"
        statuses.should_receive(:to_json).and_return(expected)
        get :friends_timeline
        response.body.should == expected
      end

    end

  end

  describe "responding to GET public_timeline" do

    before do
      login_as :quentin
      stub!(:reset_session)
    end

    it "should expose the resulting statuses as @statuses" do
      Status.should_receive(:public_timeline).and_return([mock_status])
      get :public_timeline
      assigns[:statuses].should == [mock_status]
    end

    describe "with mime type of xml" do

      it "should render the resulting statuses as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Status.should_receive(:public_timeline).and_return(statuses = mock("Array of Statuses"))
        statuses.should_receive(:to_xml).and_return("generated XML")
        get :public_timeline
        response.body.should == "generated XML"
      end

    end

    describe "with mime type of json" do

      it "should render the resulting statuses as json" do
        request.env["HTTP_ACCEPT"] = "application/json"
        Status.should_receive(:public_timeline).and_return(statuses = mock("Array of Statuses"))
        expected = "Generated JSON"
        statuses.should_receive(:to_json).and_return(expected)
        get :public_timeline
        response.body.should == expected
      end

    end

  end

  describe "responding to GET replies" do

    before do
      login_as :quentin
      stub!(:reset_session)
    end

    it "should expose the resulting statuses as @statuses" do
      Status.should_receive(:replies_for).with("user_id" => 1).and_return([mock_status])
      get :replies
      assigns[:statuses].should == [mock_status]
    end

    describe "with mime type of xml" do

      it "should render the resulting statuses as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Status.should_receive(:replies_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
        statuses.should_receive(:to_xml).and_return("generated XML")
        get :replies
        response.body.should == "generated XML"
      end

    end

    describe "with mime type of json" do

      it "should render the resulting statuses as json" do
        request.env["HTTP_ACCEPT"] = "application/json"
        Status.should_receive(:replies_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
        expected = "Generated JSON"
        statuses.should_receive(:to_json).and_return(expected)
        get :replies
        response.body.should == expected
      end

    end

  end

  describe "responding to GET friends" do

    before do
      login_as :quentin
      stub!(:reset_session)
    end

    describe "without an id in the params (for the currently authenticated user)" do

      before do
        @user = users(:quentin)
        User.should_receive(:find_by_id).with(1).and_return(@user)
      end

      it "should expose the resulting users as @users" do
        expected = [user_mock]

        expected.should_receive(:paged).and_return(expected)
        @user.should_receive(:following).and_return(expected)
        get :friends
        assigns[:users].should == expected
      end

      describe "with mime type of xml" do

        it "should render the resulting statuses as xml" do
          request.env["HTTP_ACCEPT"] = "application/xml"
          expected = [user_mock]

          expected.should_receive(:paged).and_return(expected)
          @user.should_receive(:following).and_return(users = expected)
          expected.should_receive(:to_xml).and_return("generated XML")
          get :friends
          response.body.should == "generated XML"
        end

       end

       describe "with mime type of json" do

         it "should render the resulting statuses as json" do
           request.env["HTTP_ACCEPT"] = "application/json"
           expected = [user_mock]

           expected.should_receive(:paged).and_return(expected)
           @user.should_receive(:following).and_return(expected)
           expected_result = "Generated JSON"
           expected.should_receive(:to_json).and_return(expected_result)
           get :friends
           response.body.should == expected_result
         end

       end
    end

    describe "with an id in the params" do
      before do
        @user = mock_model(User)
        User.should_receive(:find_by_id).with(1).and_return(users(:quentin))
        User.should_receive(:find_by_id_or_login).with("2").and_return(@user)
      end

      it "should expose the resulting users as @users" do
        expected = [user_mock]

        expected.should_receive(:paged).and_return(expected)
        @user.should_receive(:following).and_return(expected)
        get :friends, :id => 2
        assigns[:users].should == expected
      end

      describe "with mime type of xml" do

        it "should render the resulting statuses as xml" do
          request.env["HTTP_ACCEPT"] = "application/xml"
          expected = [user_mock]

          expected.should_receive(:paged).and_return(expected)
          @user.should_receive(:following).and_return(users = expected)
          expected.should_receive(:to_xml).and_return("generated XML")
          get :friends, :id => 2
          response.body.should == "generated XML"
        end

       end

       describe "with mime type of json" do

         it "should render the resulting statuses as json" do
           request.env["HTTP_ACCEPT"] = "application/json"
           expected = [user_mock]

           expected.should_receive(:paged).and_return(expected)
           @user.should_receive(:following).and_return(expected)
           expected_result = "Generated JSON"
           expected.should_receive(:to_json).and_return(expected_result)
           get :friends, :id => 2
           response.body.should == expected_result
         end

       end
     end

  end

  describe "responding to GET followers" do

    before do
      login_as :quentin
      stub!(:reset_session)
    end

    describe "without an id in the parms (for the currently authenticated user)" do

      before do
        @user = users(:quentin)
        User.should_receive(:find_by_id).with(1).and_return(@user)
      end

      it "should expose the resulting users as @users" do
        expected = [user_mock]

        expected.should_receive(:paged).and_return(expected)
        @user.should_receive(:followers).and_return(expected)
        get :followers
        assigns[:users].should == expected
      end

      describe "with mime type of xml" do

        it "should render the resulting statuses as xml" do
          request.env["HTTP_ACCEPT"] = "application/xml"
          expected = [user_mock]

          expected.should_receive(:paged).and_return(expected)
          @user.should_receive(:followers).and_return(users = expected)
          expected.should_receive(:to_xml).and_return("generated XML")
          get :followers
          response.body.should == "generated XML"
        end

      end

      describe "with mime type of json" do

        it "should render the resulting statuses as json" do
          request.env["HTTP_ACCEPT"] = "application/json"
          expected = [user_mock]

          expected.should_receive(:paged).and_return(expected)
          @user.should_receive(:followers).and_return(expected)
          expected_result = "Generated JSON"
          expected.should_receive(:to_json).and_return(expected_result)
          get :followers
          response.body.should == expected_result
        end
      end
    end

    describe "with an id in the parms" do

      before do
        @user = mock_model(User)
        User.should_receive(:find_by_id).with(1).and_return(users(:quentin))
        User.should_receive(:find_by_id_or_login).with("2").and_return(@user)
      end

      it "should expose the resulting users as @users" do
        expected = [user_mock]

        expected.should_receive(:paged).and_return(expected)
        @user.should_receive(:followers).and_return(expected)
        get :followers, :id => 2
        assigns[:users].should == expected
      end

      describe "with mime type of xml" do

        it "should render the resulting statuses as xml" do
          request.env["HTTP_ACCEPT"] = "application/xml"
          expected = [user_mock]

          expected.should_receive(:paged).and_return(expected)
          @user.should_receive(:followers).and_return(users = expected)
          expected.should_receive(:to_xml).and_return("generated XML")
          get :followers, :id => 2
          response.body.should == "generated XML"
        end

      end

      describe "with mime type of json" do

        it "should render the resulting statuses as json" do
          request.env["HTTP_ACCEPT"] = "application/json"
          expected = [user_mock]

          expected.should_receive(:paged).and_return(expected)
          @user.should_receive(:followers).and_return(expected)
          expected_result = "Generated JSON"
          expected.should_receive(:to_json).and_return(expected_result)
          get :followers, :id => 2
          response.body.should == expected_result
        end

      end
    end
  end

  describe "responding to GET user_timeline" do

    before do
      login_as :quentin
      stub!(:reset_session)
    end

    describe "without an id in the parms (for the currently authenticated user)" do

      before do
        @user = users(:quentin)
        User.should_receive(:find_by_id).with(1).and_return(@user)
      end

      it "should expose the resulting statuses as @statuses" do
        expected = [mock_status]
        Status.should_receive(:timeline_for).with("user_id" => 1).and_return(expected)

        get :user_timeline
        assigns[:statuses].should == expected
      end

      describe "with mime type of xml" do

        it "should render the resulting statuses as xml" do
          request.env["HTTP_ACCEPT"] = "application/xml"
          Status.should_receive(:timeline_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
          statuses.should_receive(:to_xml).and_return("generated XML")
          get :user_timeline
          response.body.should == "generated XML"
        end

      end

      describe "with mime type of json" do

        it "should render the resulting statuses as json" do
          request.env["HTTP_ACCEPT"] = "application/json"
          expected_result = "Generated JSON"
          Status.should_receive(:timeline_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
          statuses.should_receive(:to_json).and_return(expected_result)
          get :user_timeline
          response.body.should == expected_result
        end
      end
    end

    describe "with an id in the parms" do

      before do
        @user = mock_model(User, :id => 102)
        User.should_receive(:find_by_id).with(1).and_return(users(:quentin))
        User.should_receive(:find_by_id_or_login).with("102").and_return(@user)
      end

      it "should expose the resulting statuses as @statuses" do
        expected = [mock_status]
        Status.should_receive(:timeline_for).with("user_id" => 1).and_return(expected)

        get :user_timeline, :id => 102
        assigns[:statuses].should == expected
      end

      describe "with mime type of xml" do

        it "should render the resulting statuses as xml" do
          request.env["HTTP_ACCEPT"] = "application/xml"
          Status.should_receive(:timeline_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
          statuses.should_receive(:to_xml).and_return("generated XML")
          get :user_timeline, :id => 102
          response.body.should == "generated XML"
        end

      end

      describe "with mime type of json" do

        it "should render the resulting statuses as json" do
          request.env["HTTP_ACCEPT"] = "application/json"
          expected_result = "Generated JSON"
          Status.should_receive(:timeline_for).with("user_id" => 1).and_return(statuses = mock("Array of Statuses"))
          statuses.should_receive(:to_json).and_return(expected_result)
          get :user_timeline, :id => 2
          response.body.should == expected_result
        end
      end
    end
  end

  describe "responding to GET show" do

    it "should expose the requested status as @status" do
      Status.should_receive(:find).with("37").and_return(mock_status)
      get :show, :id => "37"
      assigns[:status].should equal(mock_status)
    end

    describe "with mime type of xml" do

      it "should render the requested status as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Status.should_receive(:find).with("37").and_return(mock_status)
        mock_status.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end

    describe "with mime type of json" do

      it "should render the requested status as json" do
        request.env["HTTP_ACCEPT"] = "application/json"
        Status.should_receive(:find).with("37").and_return(mock_status)
        expected = "generated JSON"
        mock_status.should_receive(:to_json).and_return(expected)
        get :show, :id => "37"
        response.body.should == expected
      end

    end

  end

  describe "responding to GET new" do

    it "should expose a new status as @status" do
      Status.should_receive(:new).and_return(mock_status)
      get :new
      assigns[:status].should equal(mock_status)
    end

  end

  describe "responding to GET edit" do

    it "should expose the requested status as @status" do
      Status.should_receive(:find).with("37").and_return(mock_status)
      get :edit, :id => "37"
      assigns[:status].should equal(mock_status)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do

      it "should expose a newly created status as @status" do
        Status.should_receive(:new).with({'these' => 'params'}).and_return(mock_status(:save => true))
        mock_status.stub!(:user=).and_return(User.new(:id => 1))
        post :create, :status => {:these => 'params'}
        assigns(:status).should equal(mock_status)
      end

      it "should redirect to the created status" do
        Status.stub!(:new).and_return(mock_status(:save => true))
        mock_status.stub!(:user=).and_return(User.new(:id => 1))
        post :create, :status => {}
        response.should redirect_to(status_url(mock_status))
      end

    end

    describe "with invalid params" do

      it "should expose a newly created but unsaved status as @status" do
        Status.stub!(:new).with({'these' => 'params'}).and_return(mock_status(:save => false))
        mock_status.stub!(:user=).and_return(User.new(:id => 1))
        post :create, :status => {:these => 'params'}
        assigns(:status).should equal(mock_status)
      end

      it "should re-render the 'new' template" do
        Status.stub!(:new).and_return(mock_status(:save => false))
        mock_status.stub!(:user=).and_return(User.new(:id => 1))
        post :create, :status => {}
        response.should render_template('new')
      end

    end

  end

  describe "responding to PUT udpate" do

    before do
      login_as :quentin
      stub!(:reset_session)
    end

    describe "with valid params" do

      it "should update the requested status" do
        Status.should_receive(:find).with("37").and_return(mock_status)
        mock_status.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :status => {:these => 'params'}
      end

      it "should expose the requested status as @status" do
        Status.stub!(:find).and_return(mock_status(:update_attributes => true))
        put :update, :id => "1"
        assigns(:status).should equal(mock_status)
      end

      it "should redirect to the status" do
        Status.stub!(:find).and_return(mock_status(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(status_url(mock_status))
      end

    end

    describe "with invalid params" do

      it "should update the requested status" do
        Status.should_receive(:find).with("37").and_return(mock_status)
        mock_status.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :status => {:these => 'params'}
      end

      it "should expose the status as @status" do
        Status.stub!(:find).and_return(mock_status(:update_attributes => false))
        put :update, :id => "1"
        assigns(:status).should equal(mock_status)
      end

      it "should re-render the 'edit' template" do
        Status.stub!(:find).and_return(mock_status(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested status" do
      Status.should_receive(:find).with("37").and_return(mock_status)
      mock_status.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "should redirect to the statuses list" do
      Status.stub!(:find).and_return(mock_status(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(statuses_url)
    end

  end

end

