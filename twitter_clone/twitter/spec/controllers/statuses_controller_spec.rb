require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatusesController do

  def mock_status(stubs={})
    @mock_status ||= mock_model(Status, stubs)
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
        post :create, :status => {:these => 'params'}
        assigns(:status).should equal(mock_status)
      end

      it "should redirect to the created status" do
        Status.stub!(:new).and_return(mock_status(:save => true))
        post :create, :status => {}
        response.should redirect_to(status_url(mock_status))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved status as @status" do
        Status.stub!(:new).with({'these' => 'params'}).and_return(mock_status(:save => false))
        post :create, :status => {:these => 'params'}
        assigns(:status).should equal(mock_status)
      end

      it "should re-render the 'new' template" do
        Status.stub!(:new).and_return(mock_status(:save => false))
        post :create, :status => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

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
