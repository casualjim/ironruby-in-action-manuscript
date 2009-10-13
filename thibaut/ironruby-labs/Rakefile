require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'fileutils'

desc "Check if Mono is recent enough and correctly installed"
task :happy do
  print "Checking mono >= 2.2 installed - "
  version = `mono --version`.scan(/Mono JIT compiler version (\d+.\d+)/).to_s
  raise "FAILED! #{version}" unless version >= "2.2"
  puts "OK (#{version})"
end

desc "Run IronRuby on Mono with the given args (ex: rake run ui/test_form_with_button.rb)"
task :run do
  system! ["mono Release/ir.exe",ARGV[1..-1]].flatten.join(' ')
end
  
desc "Download the IronRuby nightly binaries"
task :download do
  url = latest_dlr_url
  zip = url.split('/').last
  system! "curl -O #{url}" unless File.exists?(zip)
  system! "unzip #{zip}"
end

desc "Revert to a previously downloaded zip of binaries, in case something doesn't work anymore in latest build"
task :revert do
  version = ENV['version']
  raise "specify a DLR version to revert to." if version.nil?
  system! "unzip DLR.#{version}.release.zip"
end

def latest_dlr_url
  source = "http://nightlybuilds.cloudapp.net/rss.ashx?project=dlr"
  rss = RSS::Parser.parse(open(source), false)
  rss.items.find { |e| e.link =~ /DLR\.\d+\.release\.zip/ }.link
end
  
def system!(cmd)
  raise "Failed: #{cmd}" unless system(cmd)
end
