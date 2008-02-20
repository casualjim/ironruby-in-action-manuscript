spec = Gem::Specification.new do |s| 
  s.name = "LightSpeed Class Generator"
  s.version = "0.0.1"
  s.author = "Ivan Porto Carrero"
  s.email = "ivan@flanders.co.nz"
  s.homepage = "http://flanders.co.nz/blog/"
  s.platform = Gem::Platform::RUBY
  s.summary = "This package helps you to generate models for the LightSpeed ORM given a database"
  s.files = FileList["{lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "name"
  s.test_files = FileList["{test}/**/*test.rb"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.add_dependency("ruby-dbi")
  s.add_dependency("yaml")
  s.add_dependency("rexml")
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 
