APP_ROOT ||= File.dirname(__FILE__) + '/../' 
APP_DIRS ||= %w(config lib) 
EXCLUSIONS ||= %w(boot main visual_studio light_speed_conventionaliser)

require 'active_support'
require 'dbi'


module Inflector
  def pascalize(word)
    word.gsub(/^[A-Z]/){ |capital| capital.downcase }
  end
end


require APP_ROOT + 'lib/sql_connection_manager'
require APP_ROOT + 'lib/meta_data'
require APP_ROOT + 'lib/light_speed_repository'
require APP_ROOT + 'lib/light_speed_entity'


