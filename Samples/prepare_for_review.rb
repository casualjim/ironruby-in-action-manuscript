require 'ftools'
require 'fileutils'

chapters = {
  "Chapter 2" => {
    "Listing2.3"  => { :name => "album" },
    "Listing2.4"  => { :name => "inheritance" },
    "Listing2.5"  => { :name => "numbers" },
    "Listing2.6"  => { :name => "arrays" },
    "Listing2.7"  => { :name => "hashes" },
    "Listing2.8"  => { :name => "album_list_test", :folder => "test" },
    "Listing2.9"  => { :name => "album_list" },
    "Listing2.10" => { :name => "strings" },
    "Listing2.11" => { :name => "regular_expressions"},
    "Listing2.12" => { :name => "ifthenelse"},
    "Listing2.13" => { :name => "casewhen"},
    "Listing2.14" => { :name => "loops" },
    "Listing2.15" => { :name => "code_blocks" },
    "Listing2.16" => { :name => "code_blocks_parameters" },
    "Listing2.17" => { :name => "transactional_resource" },
    "Listing2.18" => { :name => "iterators" },
    "Listing2.19" => { :name => "album_list_with_iterator" },
    "Listing2.20" => { :name => "closures" },
    "Listing2.21" => { :name => "modules/string_ops" },
    "Listing2.22" => { :name => "modules/modules" },
    "Listing2.24" => { :name => "modules/song_ops" },
    "Listing2.25" => { :name => "modules/mixins" },
    "Listing2.26" => { :name => "metaprogramming/method_missing" },
    "Listing2.27" => { :name => "metaprogramming/define_method" },
    "Listing2.28" => { :name => "metaprogramming/csv_record" },
    "Listing2.29" => { :name => "metaprogramming/consumer" }
  },
  "Chapter 3" => { 
    "Listing3.4" => { :name => "xaml_main", :folder => "wpf" },
    "Listing3.5" => { :name => "biffy", :folder => "wpf" },
    "Listing3.6" => { :name => "main", :folder => "wpf" }
  }
}

dir = File.dirname(__FILE__)
chapters.each do |folder, files|
  new_folder = "#{dir}/../Code Samples Review part 1/#{folder}"
  Dir.mkdir new_folder unless File.exists? new_folder
  files.each do |new_name, file|
    from_solution = "#{dir}/IronRubyInAction/IronRuby/#{file[:folder].nil? ? "lib" : file[:folder]}/#{file[:name]}.rb"
    to_listings = "#{dir}/../Code Samples Review part 1/#{folder}/#{new_name}.rb"
    File.move from_solution, to_listings
  end
end