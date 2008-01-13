class AlbumList
  
  def initialize
    @internal_list = Array.new
  end
  
  # Appends an item to the album list
  #:return: => AlbumList
  #:arg: album => Album 
  def append(album)
    @internal_list.push(album)
    
    self
  end
  
  # Finds an album by title 
  #:return: => Album
  #:arg: name => The complete title of an album
  def find_by_name(name)
    @internal_list.find {|album| album.name == name}
  end
  
  # Removes an album from the list. The name property of the album is mandatory
  #:return: => AlbumList
  #:arg: album => Album to delete
  def remove(album)
    found = find_by_name(album.name)
    @internal_list.delete(found) unless found.nil?
    
    self
  end
  
  #:return: => The count of the number of items in this container
  def count
    @internal_list.length
  end
  
  #:return: => Album found at the specified index
  #:arg: index => a number indicating the item we want to fetch from the container
  def [](index)
    @internal_list[index]
  end
end