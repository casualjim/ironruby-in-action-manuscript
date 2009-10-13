require File.dirname(__FILE__) + '/common'

form = Form.new

menu = MainMenu.new

# indent to make it easier to read
fileItem = menu.menu_items.add("&File")
  newItem = fileItem.menu_items.add("&New")
    newItem.menu_items.add("Spreadsheet")
    newItem.menu_items.add("Document")
  fileItem.menu_items.add("&Quit").click { |s,e| Application.Exit }

toolsItem = menu.menu_items.add("&Tools")
  toolsItem.menu_items.add("&PowerBlade").click { |s,e| MessageBox.Show("Powerblades are amazing...") }
  toolsItem.menu_items.add("&Scissors")

form.menu = menu

Application.Run(form)
