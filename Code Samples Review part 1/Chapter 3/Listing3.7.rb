p "loading components, please wait..."

# get the necessary assemblies loaded for .NET
require 'mscorlib'
require 'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089' 
require 'System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'PresentationFramework, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'PresentationCore, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'

# include some namespaces for easy access
include System
include System::Windows
include System::Windows::Controls
include System::Windows::Markup
include System::Windows::Media
include System::Windows::Media::Animation
include System::Xml

# define an application
class XamlApplication < Application

  def initialize    
    run yield
  end  
  
end

#run the application
xaml_path = "Listing3.6.xaml"

XamlApplication.new do
  obj = XamlReader.load XmlReader.create(xaml_path)
  
  obj.find_name('get_url_button').click do 
    obj.find_name('web_url_display').source = obj.find_name('web_url').text
  end
  obj
end