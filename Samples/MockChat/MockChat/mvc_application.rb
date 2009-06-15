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


module StringExtensions
  def camelize(first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      self.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    else
      self[0...1].downcase + camelize(self)[1..-1]
    end
  end

  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

class String
  include StringExtensions
end

class System::String
  include StringExtensions
end
