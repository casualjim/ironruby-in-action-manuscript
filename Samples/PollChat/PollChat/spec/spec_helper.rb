require 'spec'
require 'mscorlib'
require 'caricature'
require 'caricature/clr'
require 'caricature/clr/aspnet_mvc'

MVC_ROOT = File.expand_path(File.dirname(__FILE__))

%w(bin lib Models lib/IronRuby lib/ruby/1.8).each { |s| $: << File.dirname(__FILE__) + "/../#{s}"}

# load the libraries for the application
require File.dirname(__FILE__) + "/../mvc_application"


Spec::Matchers.define :eql_clr_string do |string|
  match do |clr_string|
    clr_string == string.to_s.to_clr_string
  end
end
