require 'lib/fs_watcher'

filesystem do
  
  watch(File.expand_path(File.join(File.dirname(__FILE__), "tmp"))) do
    on_change { |args| puts "changed #{args.full_path}" }
    on_create { |args| puts "created #{args.full_path}" }
  end
end

while cmd = gets
  if cmd.downcase.chomp == "exit"
    exit 0
  else
    puts "==> #{eval cmd}"
  end
end