require 'lib/fs_watcher'

filesystem do
  
  watch(File.expand_path(File.join(File.dirname(__FILE__), "tmp"))) do
    on_change { |args| puts "changed #{args.path}" }
    on_create { |args| puts "changed #{args.path}" }
  end
end

while cmd = gets
  exit(0) if cmd.downcase == "exit"
end