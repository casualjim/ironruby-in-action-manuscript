# add some load paths
%w(bin lib Models lib/IronRuby lib/ruby/1.8).each { |s| $: << File.dirname(__FILE__) + "/#{s}"}

load_assembly 'Mindscape.LightSpeed'
load_assembly 'Mindscape.LightSpeed.linq'
load_assembly 'MockChat.Models'
load_assembly 'MockChat'

# include common namespaces
include System::Web::Mvc
include Mindscape::LightSpeed::Querying

include MockChat::Models

