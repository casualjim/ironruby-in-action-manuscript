$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'menu_builder'

form = Form.new

form.menu = MainMenu.build do
  item("&File") {
    item("&New") {
      item("Spreadsheet")
      item("Document")
    }
    item("&Quit").click { Application.Exit }
  }
  item("&Tools") {
    item("&PowerBlade").click { MessageBox.Show("Powerblades are amazing...") }
    # alternate form, with lambda instead of chained call
    item "&Scissors", lambda { MessageBox.Show("Scissors are nice, too") }
  }
end

Application.Run(form)
