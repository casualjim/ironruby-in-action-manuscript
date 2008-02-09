APP_ROOT = File.dirname(__FILE__) + '/../' 

require 'yaml'
require 'dbi'
require 'rexml/document'
require 'lib/inflector'
require "lib/inflections"
require "lib/string"
include REXML

require APP_ROOT + 'lib/light_speed_repository'