$:.unshift app_path unless $:.include app_path = File.expand_path(File.dirname(__FILE__))

def require_greedy(glob=File.dirname(__FILE__) + "/**/*.rb")
  glob = "#{glob}/**/*.rb" if File.exists?(glob) and File.directory?(glob)
  Dir.glob(glob) { |file| require File.expand_path(file) }
end

require_greedy


