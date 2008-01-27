# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'rubygems'
require 'active_record'
require 'yaml'

RAILS_ENV = 'development'

dbconfig = YAML::load(File.open('../config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig[RAILS_ENV.to_sym])
puts "Hello World"
