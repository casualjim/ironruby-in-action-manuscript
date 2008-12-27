
cu = 3
statuses =  (7..30).collect do |ind|
      if cu == 3
          cu = 1
      else
          cu = cu + 1
      end
      {
        :id => ind, 
        :source => "ironruby in action", 
        :source_url => "http://manning.com/carrero",
        :user_id => cu,
        :text => "the #{ind.ordinalize} tweet in the sample"
      }
  end
  
puts statuses.to_yaml