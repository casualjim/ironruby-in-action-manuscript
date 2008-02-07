
APP_ROOT ||= File.dirname(__FILE__) + '/../' 
APP_DIRS ||= %w(config lib) 
EXCLUSIONS ||= %w(boot main visual_studio light_speed_conventionaliser)


require 'dbi'

def exclusion?(file)  
  APP_DIRS.each do |dir|
    result = EXCLUSIONS.any?{|exclusion|  exclusion === file}
    return result if result
  end
  false
end

APP_DIRS.each do |app_dir| 
  Dir["#{app_dir}/*.rb"].each do |file|
    require APP_ROOT + "#{file}" unless exclusion? file
  end
end


# 
# 
# require APP_ROOT + 'lib/sql_connection_manager'
# require APP_ROOT + 'lib/meta_data'
# require APP_ROOT + 'lib/light_speed_repository'
# require APP_ROOT + 'lib/light_speed_entity'
