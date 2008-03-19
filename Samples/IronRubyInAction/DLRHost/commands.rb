def show_me
    puts "from within a command"
end

$my_container.commands[:show_me]= methods[:show_me]
#puts $version
#puts $my_container.version
#puts "Global: #{$version}"
#puts "instance: #{@version}"
