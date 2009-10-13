$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'magic'
require 'menu_builder'

=begin
a few links that might come handy:
- http://dotnetperls.com/Content/DataGridView-Tips.aspx
- http://goneale.wordpress.com/2009/02/10/add-image-column-to-datagridview-with-enum-support/
=end

form = Magic.build do
  form(:text => "DataGridView sample", :width => 800, :height => 600) do
    # nifty - current Magic.build makes it possible to reuse the control that has been added
    @grid = data_grid_view :dock => DockStyle.fill
    @grid.column_count = 2
    @grid.columns[0].name = "First name"
    @grid.columns[1].name = "Last name"
    
    @grid.rows.add("Thibaut","Barrère") # using my name with its nasty accent - utf-8 ?
  end
end

Application.Run(form)