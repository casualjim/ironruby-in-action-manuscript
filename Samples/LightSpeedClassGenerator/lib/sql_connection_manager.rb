module DB
	
	module SqlConnectionManager

		DEFAULT_CONFIG_PATH = File.dirname(__FILE__) + '/../config/database.yml'
		
		attr_reader :connection_string, :connection
			
		def initialize(config=DEFAULT_CONFIG_PATH)
		  if config.is_a? Hash
		    initialize_config config
		  else
		    read_config config, 'sqlserver' unless config.is_a? Hash
	    end
		end
		
		def read_config(config_path, config_name = 'sqlserver')
			initialize_config(YAML::load(File.open(config_path || DEFAULT_CONFIG_PATH))[config_name])
		end
		
		def initialize_config(config)
		  @config = config
			@connection=nil
	  end
		
		def is_odbc?
		  true unless @config.nil? || @config['dsn'].nil?
		end
		
		def connection_string
		  "DBI:ODBC:#{@config['dsn']}" unless @config.nil?
	  end
	
	end
	
	
	class DbiSqlServer 
		include SqlConnectionManager
		
		
		def connection
			if @connection.nil?
			  @connection = DBI.connect(connection_string, @config['username'], @config['password'])
			end
			@connection
		end
		
		def connection_string
		  if is_odbc?
		    "DBI:ODBC:#{@config['dsn']}"
		  else
		    "DBI:ADO:Provider=SQLOLEDB;Data Source=#{@config['host']};Initial Catalog=#{@config['database']};User ID=#{@config['username']};Password=#{@config['password']};"
	    end
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
		
		def execute_non_query(sql_statement)
		  connection.do sql_statement
		end
		
	end
	
end