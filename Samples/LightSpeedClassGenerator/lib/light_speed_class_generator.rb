dir = File.dirname(__FILE__) 

require 'yaml'
require 'dbi'
require 'rexml/document'
require dir + '/inflector'
require dir + "/inflections"
require dir + "/string"
include REXML

require APP_ROOT + 'lib/light_speed_repository'


ls = LightSpeedRepository.new ARGV[0], ARGV[1], ARGV[2]
ls.excluded_tables = %(KeyTable)
ls.add_files_to_vs_project
