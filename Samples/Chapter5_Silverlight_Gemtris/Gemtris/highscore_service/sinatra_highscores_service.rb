require 'rubygems'
require 'sinatra'
require 'rexml/document'
include REXML # so we don't have to prefix everything

class SinatraHighscoresService
  
  get '/highscores' do
    scores_xml = (Document.new File.new 'scores.xml').root
    scores_xml.to_s
  end
  
  post '/highscores' do
    file = File.new('scores.xml', 'r+')
    scores_xml = Document.new(file)
    scores = scores_xml.root
    new_entry = scores << Element.new("score")
    new_entry['player'] = params[:name]
    new_entry.text = params[:score]
    open('scores.xml', 'w'){ |f| scores_xml.write f }
    scores_xml
  end
  
end