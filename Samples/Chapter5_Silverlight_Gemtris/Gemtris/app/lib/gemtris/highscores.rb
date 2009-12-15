require 'bin/System.Xml' 
#require 'bin/System.Xml.Linq' 
include System::Xml
#include System::Xml::Linq
include System::Net

class Gemtris::Highscores
  
  URL = System::Uri.new('http://localhost:4567/highscores')
  
  def self.get
    client = WebClient.new
    client.download_string_completed { |sender, e| yield e.result if block_given? }
    client.download_string_async URL
  end
  
  def self.submit(name, score)
    client = WebClient.new
    client.upload_string_completed { |sender, e| yield sender, e if block_given? }
    client.upload_string_async URL, "POST", "name=#{name}&amp;score=#{score}"
  end
  
end