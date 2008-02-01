module DB
	
	module SqlConnectionManager

		DEFAULT_CONFIG_PATH = File.dirname(__FILE__) + '/../config/database.yml'
		
		attr_reader :connection_string, :connection
			
		def initialize(config_path=DEFAULT_CONFIG_PATH)
			read_config config_path, 'sqlserver'
		end
		
		def read_config(config_path, config_name)
			config = YAML::load(File.open(config_path || DEFAULT_CONFIG_PATH))[config_name]
			@host= config['host']
			@username = config['username']
			@password = config['password']
			@database = config['database']
			@connection=nil
		end
	
	end
	
	
	class DbiSqlServer 
		include SqlConnectionManager
		
		
		def connection
			if @connection.nil?
				@connection_string = "DBI:ADO:Provider=SQLOLEDB;Data Source=#{@host};Initial Catalog=#{@database};User ID=#{@username};Password=#{@password};"
				@connection = DBI.connect(@connection_string, @username, @password)
			end
			@connection
		end
		
		def fetch_all(sql_statement)
			result = []
			connection.execute sql_statement do |statement|
				while row = statement.fetch do 
					r = {}
					row.each_with_name do |val, name|
						r[name.to_sym] = val
					end
					result << r
				end
			end
			result
		end
		
	end
	
#	require 'lib/connection_manager.rb'
#	db = DB::DbiSqlServer.new
	
	
end