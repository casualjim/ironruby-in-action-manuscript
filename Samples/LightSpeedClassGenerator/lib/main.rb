# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
APP_ROOT = File.dirname(__FILE__) + '/../' 
APP_DIRS = %w(config lib) 
require File.dirname(__FILE__) + "/../config/boot.rb"



md = DB::MetaData.new

md.tables.each{ |table| puts table[:name] }
puts md.is_join_table?("EmployeeTerritories")