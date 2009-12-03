require File.dirname(__FILE__) + "/../spec_helper"

class TheModel
  include YamlPersistence
end

describe YamlPersistence do

  it "should add a model_name class method" do
    TheModel.should respond_to(:model_name)
  end

  it "should have a model name that is the underscored class name" do
    TheModel.model_name.should == "the_model"
  end

  it "should have a store_path" do
    TheModel.store_path.should == File.expand_path(File.dirname(__FILE__) + "/..") + "/AppData/the_model"
  end

  

end