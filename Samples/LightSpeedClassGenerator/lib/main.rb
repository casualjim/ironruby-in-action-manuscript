dir = File.expand_path(File.dirname(__FILE__))

require 'yaml'
require 'dbi'
require 'rexml/document'
require "ftools"
require dir + '/inflector'
require dir + "/inflections"
require dir + "/string"
include REXML

require dir + '/light_speed_repository'

proj_file_location = ARGV[0] || Dir['*.csproj'][0]

if proj_file_location.nil? or proj_file_location.empty?
	puts "Please specify a path to the csproj file to append the model files to."
end

#puts proj_file_location

ls = LightSpeedRepository.new proj_file_location, ARGV[1], ARGV[2], ARGV[3]
ls.excluded_tables = %w(KeyTable sysdiagrams)
ls.add_files_to_vs_project