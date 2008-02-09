
require File.dirname(__FILE__) + "/../config/boot.rb"


ls = LightSpeedRepository.new ARGV[0], ARGV[1], ARGV[2]
ls.excluded_tables = %(KeyTable)
ls.add_files_to_vs_project

# 
# 
# require APP_ROOT + 'lib/sql_connection_manager'
# require APP_ROOT + 'lib/meta_data'
# require APP_ROOT + 'lib/light_speed_repository'
# require APP_ROOT + 'lib/light_speed_entity'
