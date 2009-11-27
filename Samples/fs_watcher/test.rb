require 'lib/fs_watcher'

watchers = filesystem do
  
  watch(File.expand_path(File.join(File.dirname(__FILE__), "tmp"))) do
    on_change { |args| puts "changed #{args.full_path}" }
  end
end

fpath = File.expand_path(File.join(File.dirname(__FILE__), "tmp", Time.now.strftime("%Y%m%d%H%M%s")))
puts fpath
while cmd = gets.chomp
  exit(0) if cmd == "exit"
  open(fpath, 'w'){ |f| f.puts '"Mr. Worf, scan that ship." "Aye Captain. 300 dpi?"' } if cmd == "hit"
end
