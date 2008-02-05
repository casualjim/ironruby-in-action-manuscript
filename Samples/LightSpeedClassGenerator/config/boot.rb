APP_ROOT ||= File.dirname(__FILE__) + '/../' 
APP_DIRS ||= %w(config lib) 

require 'active_support'
require 'dbi'

require APP_ROOT + 'lib/sql_connection_manager'
require APP_ROOT + 'lib/meta_data'
require APP_ROOT + 'lib/light_speed_entity'
require APP_ROOT + 'lib/light_speed_repository'

