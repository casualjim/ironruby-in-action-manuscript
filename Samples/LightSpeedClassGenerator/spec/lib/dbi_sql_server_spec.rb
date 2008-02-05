require File.dirname(__FILE__) + '/../spec_helper' 
require File.dirname(__FILE__) + '/../../lib/sql_connection_manager.rb'
require File.dirname(__FILE__) + '/../../lib/meta_data.rb'


describe DB::DbiSqlServer do

  it "should return a connection" do
    @dbi_sql_server = DB::DbiSqlServer.new 
    @dbi_sql_server.should_not be_nil
    @dbi_sql_server.connection.should_not be_nil
  end
  
  it "should say it's an ODBC connection when a dsn is provided" do
    @dbi_sql_server = DB::DbiSqlServer.new 'dsn' => 'myDSN'
    @dbi_sql_server.should be_odbc
    
  end
  
  it "should return the correct connection string for an ODBC connection" do
    @dbi_sql_server = DB::DbiSqlServer.new 'dsn' => 'myDSN'
    @dbi_sql_server.connection_string.should == 'DBI:ODBC:myDSN'
  end
end

