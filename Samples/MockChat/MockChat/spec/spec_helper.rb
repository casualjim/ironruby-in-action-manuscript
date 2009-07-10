require 'spec'
require 'mscorlib'
require 'caricature'
require 'caricature/clr'
require 'caricature/clr/aspnet_mvc'

%w(bin lib Models lib/IronRuby lib/ruby/1.8).each { |s| $: << File.dirname(__FILE__) + "/../#{s}"}

load_assembly 'Mindscape.LightSpeed'
load_assembly 'Mindscape.LightSpeed.linq'
load_assembly 'MockChat.Models'
load_assembly 'MockChat'

# include common namespaces
include System::Web::Mvc
include Mindscape::LightSpeed
include Mindscape::LightSpeed::Logging
include Mindscape::LightSpeed::Querying

include MockChat::Models

$context = LightSpeedContext.of(MockChatUnitOfWork).new

Spec::Matchers.define :eql_clr_string do |string|
  match do |clr_string|
    clr_string == string.to_s.to_clr_string
  end
end


