$:.unshift app_path unless $:.include app_path = File.expand_path(File.dirname(__FILE__))

def require_all(glob=File.dirname(__FILE__) + "/**/*.rb")
  glob = "#{glob}/**/*.rb" if File.exists?(glob) and File.directory?(glob)
  Dir.glob(glob) { |file| require file }
end

require_all
