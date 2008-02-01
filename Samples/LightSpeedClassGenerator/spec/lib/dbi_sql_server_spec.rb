require File.dirname(__FILE__) + '/../spec_helper' 
require File.dirname(__FILE__) + '/../../lib/sql_connection_manager.rb'
require File.dirname(__FILE__) + '/../../lib/meta_data.rb'


describe DB::DbiSqlServer do
  before(:each) do
    @dbi_sql_server = DB::DbiSqlServer.new    
  end

  it "should return a connection" do
    @dbi_sql_server.should_not be_nil
    @dbi_sql_server.connection.should_not be_nil
  end
end

