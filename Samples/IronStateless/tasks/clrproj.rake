ENV['HOME'] ||= ENV['USERPROFILE']
EXCLUDED_EXTENSIONS   = %w[.old .suo .vspscc .vssscc .user .log .pdb .cache .swp]
EXCLUDED_FILES = "dirs.proj makefile sources .gitignore"
CURRENT_DIR = File.dirname(File.expand_path(__FILE__))
require 'pathname'

class Pathname
  def filtered_subdirs(extras = [])
    return [] unless exist?
    filtered_subdirs = subdirs.find_all { |dir| (dir.to_a & (EXCLUDED_DIRECTORIES + extras)) == [] }
    result = filtered_subdirs.map { |dir| self + dir }
    result.unshift self
  end

  def subdirs
    glob("**/*", File::FNM_DOTMATCH).find_all { |path| (self + path).directory? }
  end

  def files
    raise "Cannot call files on a filename path: #{self}" if !directory?
    entries.find_all { |e| !(self + e).directory? }.sort
  end

  def filtered_files
    raise "Cannot call filtered_files on a filename path: #{self}" if !directory?
    files.find_all { |f| !EXCLUDED_EXTENSIONS.include?((self + f).extname) }
  end
end

class Configuration
  class Group
    attr_reader :super_group

    def initialize(name, super_group)
      @name = name
      @switches = {}
      @references = []
      @super_group = super_group
    end

    def switches(config, *args)
      @switches[config] ||= []
      @switches[config] += args
    end

    def references(*refs)
      @references += refs
    end

    def remove_switches(config, *args)
      args.each { |arg| @switches[config].delete arg } unless @switches[config].nil?
    end

    def get_switches(config)
      all = @switches[:all].nil? ? [] : @switches[:all]
      (@switches[config].nil? ? [] : @switches[config]) + all
    end

    def get_references
      @references
    end

    def framework_path(*args, &b)
      @framework_path = (if args.length == 0
        b.call
      elsif args.length == 1
        args.first
      else
        raise 'framework_path must be called with either a path or a block that defines a path'
      end << nil)
    end

    def resolve_framework_path(path)
      @framework_path.each do |candidate|
        raise "cannot resolve path #{path}" if candidate.nil?
        candidate_path = candidate + path
        break candidate_path if candidate_path.file?
      end
    end
  end

  def self.define(&b)
    @master = {}
    instance_eval(&b)
  end

  def self.group(*args, &b)
    name = args.first
    super_group = args.length == 2 ? @master[args.last] : nil
    @master[name] ||= Group.new(name, super_group)
    @master[name].instance_eval(&b)
  end

  def self.get_switches(group, config)
    result = []
    current = @master[group]
    while !current.nil?
      result += current.get_switches(config)
      current = current.super_group
    end
    result
  end

  def self.get_references(group)
    result = []
    current = @master[group]
    while !current.nil?
      result += current.get_references
      current = current.super_group
    end
    result.map { |assembly| resolve_framework_path(group, assembly) }
  end

  def self.resolve_framework_path(group, path)
    @master[group].resolve_framework_path(path)
  end

  def self.mono?
    return true if ENV['mono']
    ENV['OS'] != "Windows_NT"
  end
end
Configuration.define do
  group(:common) {
    switches :all, 'nologo', 'noconfig', 'nowarn:1701,1702', 'errorreport:prompt', 'warn:4', 'warnaserror-'
    switches :debug, 'define:"DEBUG;TRACE"', 'debug+', 'debug:full', 'optimize-'
    switches :release, 'define:TRACE', 'optimize+'
    references 'System.dll'
  }
  group(:desktop, :common) {
    references 'System.Configuration.dll'
  }
  group(:silverlight, :common) {
    switches :all, 'define:SILVERLIGHT', 'nostdlib+', 'platform:AnyCPU'
    references 'mscorlib.dll'
  }
  unless mono?
    group(:desktop) {
      framework_path [Pathname.new(ENV['windir'].dup) + 'Microsoft.NET/Framework/v2.0.50727',
                      Pathname.new('c:/program files/reference assemblies/microsoft/framework/v3.5')]
    }
    group(:silverlight) {
      framework_path [Pathname.new('c:/program files/microsoft silverlight/2.0.30523.6')]
    }
  else
    group(:mono) {
      framework_path {
        libdir = IO.popen('pkg-config --variable=libdir mono').read.strip
        path = [Pathname.new(libdir) + 'mono' + '2.0', Pathname.new('/usr/lib/mono/2.0/')]
        path << Pathname.new(ENV['MONO_LIB'] + '/mono/2.0/') unless ENV['MONO_LIB'].nil?
        path
      }
      switches :all, 'noconfig'
      remove_switches ['warnaserror+']
    }
  end
end



module IronRubyUtils
  def banner(message)
    rake_output_message "-" * 79
    rake_output_message message
    rake_output_message "-" * 79
  end

  def copy_dir(source_dir, target_dir, options = '')
    log_filename = Pathname.new(Dir.tmpdir) + "rake_transform.log"
    exec_f %Q{robocopy "#{source_dir}" "#{target_dir}" #{DEFAULT_ROBOCOPY_OPTIONS} "/LOG+:#{log_filename}" #{options}}
  end
  # Low-level command helpers

  def is_test?
    ENV['test']
  end

  def mono?
    Configuration.mono?
  end

  def rake_version
    cmd = mono? ? "rake" : "rake.bat"
    `#{cmd} --version`.chomp.gsub(/.*?(\d\.\d\.\d)/, '\1')
  end

  def exec(cmd)
    if is_test?
      rake_output_message ">> #{cmd}"
    else
      sh cmd
    end
  end

  def exec_net(cmd)
    unless mono?
      exec cmd
    else
      exec "mono #{cmd}"
    end
  end

  def exec_f(cmd)
    begin
      exec(cmd)
    rescue
    end
  end


  def configuration
    ENV['configuration'] ? ENV['configuration'].to_sym : :debug
  end

  def platform
    ENV['platform'].nil? ? :windows : ENV['platform'].to_sym
  end

  def clr
    unless mono?
      ENV['clr'] ? ENV['clr'].to_sym : :desktop
    else
      :mono
    end
  end

  def build_path
    project_root + Pathname.new(File.join("Bin", "#{clr == :desktop ? configuration : "#{clr}_#{configuration}"}"))
  end

  def project_root
    Pathname.new(File.expand_path(File.join(CURRENT_DIR, "..","..")))
  end
end

class CSProjCompiler

  include IronRubyUtils

  def initialize(&b)
    @targets = {}
    instance_eval(&b)
  end

  def dir(target)
    Pathname.new(@targets[target][:dir])
  end

  def compile(name)
    banner name.to_s
    args = @targets[name.to_sym]
    working_dir = File.expand_path(args[:dir], File.dirname(__FILE__))
    build_dir = build_path

    Dir.chdir(working_dir) do |p|
      cs_args = ["out:\"#{build_dir + args[:output]}\""]
      cs_args += references(args[:references], working_dir).map { |ref| "r:\"#{ref}\"" }
      cs_args += compiler_switches
      cs_args += args[:switches] if args[:switches]

      if args[:resources]
        resgen working_dir, args[:resources]
        args[:resources].each_value { |res| cs_args << "resource:\"#{build_path + res}\"" }
      end
      cmd = ''
      cmd << CS_COMPILER
      if cs_args.include?('noconfig')
        cs_args.delete('noconfig')
        cmd << " /noconfig"
      end

      temp = Tempfile.new(name.to_s)
      cs_args.each { |opt| temp << ' /' + opt + "\n"}
      options = get_compile_path_list(args[:csproj]).join("\n")
      temp.puts options
      temp.close

      cmd << " @" << temp.path
      exec cmd
    end
  end

  def get_case_sensitive_path(pathname)
    return "../AssemblyVersion.cs" if pathname == "..\\AssemblyVersion.cs"
    elements = pathname.split '\\'
    result = Pathname.new '.'
    elements.each do |element|
      entry = result.entries.find { |p| p.downcase == element.downcase }
      result = result + entry unless entry.nil?
    end
    result.to_s
  end

  def get_compile_path_list(csproj)
    csproj ||= '*.csproj'
    cs_proj_files = Dir[csproj]
    if cs_proj_files.length == 1
      doc = REXML::Document.new(File.open(cs_proj_files.first))
      result = doc.elements.collect("/Project/ItemGroup/Compile") { |c| c.attributes['Include'] }
      result.delete_if { |e| e =~ /(Silverlight\\SilverlightVersion.cs|System\\Dynamic\\Parameterized.System.Dynamic.cs)|\.\./ }
      result.map! { |p| get_case_sensitive_path(p) } if mono?
      result
    else
      raise ArgumentError.new("Found more than one .csproj file in directory! #{cs_proj_files.join(", ")}")
    end
  end


  def resgen(base_path, resource_map)
    base_path = Pathname.new(base_path)
    resource_map.each_pair do |input, output|
      exec %Q{resgen "#{base_path + input.dup}" "#{build_path + output}"}
    end
  end


  def resolve_framework_path(file)
    Configuration.resolve_framework_path(clr, file)
  end


  def compiler_switches
    Configuration.get_switches(clr, configuration)
  end

  def references(refs, working_dir)
    references = Configuration.get_references(clr)
    refs.each do |ref|
      references << if ref =~ /^\!/
                      resolve_framework_path(ref[1..-1])
                    else
                      (build_path + ref)
                    end
    end if refs
    references
  end


  def clean
    FileUtils.rm_rf build_path
    FileUtils.mkdir_p build_path
  end

  def transform_config(source_path, target_path, paths)
    file = File.new source_path
    doc = Document.new file

    # replace LibraryPaths
    options = XPath.each(doc, '/configuration/microsoft.scripting/options/set') do |node|
      if node.attributes['language'] == 'Ruby' && node.attributes['option'] == 'LibraryPaths'
        node.attributes['value'] = paths
      end
    end

    File.open(target_path, 'w+') do |f|
      f.write doc.to_s
    end
  end

  def transform_config_file(configuration, source_path, target_build_path)
    # signing is on for IronRuby in Merlin, off for SVN and Binary
    layout = {'Merlin' => { :LibraryPaths => '..\..\Languages\Ruby\libs;..\..\..\External.LCA_RESTRICTED\Languages\Ruby\Ruby-1.8.6p287\lib\ruby\site_ruby\1.8;..\..\..\External.LCA_RESTRICTED\Languages\Ruby\Ruby-1.8.6p287\lib\ruby\site_ruby;..\..\..\External.LCA_RESTRICTED\Languages\Ruby\Ruby-1.8.6p287\lib\ruby\1.8' },
              'Binary' => { :LibraryPaths => '..\lib\IronRuby;..\lib\ruby\site_ruby\1.8;..\lib\ruby\site_ruby;..\lib\ruby\1.8' },
              'MerlinMono' => { :LibraryPaths => '../../Languages/Ruby/libs;../../../External.LCA_RESTRICTED/Languages/Ruby/Ruby-1.8.6p287/lib/ruby/site_ruby/1.8;../../../External.LCA_RESTRICTED/Languages/Ruby/Ruby-1.8.6p287/lib/ruby/site_ruby;../../../External.LCA_RESTRICTED/Languages/Ruby/Ruby-1.8.6p287/lib/ruby/1.8' },
              'MonoRL' => { :LibraryPaths => '../lib;../lib/ironruby;../lib/ruby/site_ruby/1.8/;../lib/ruby/site_ruby/;../lib/ruby/1.8/' } }

    transform_config source_path, target_build_path, layout[configuration][:LibraryPaths]
  end

  def move_config(name = "ir.exe.config")
    source = project_root + "Config/Unsigned/App.config"
    config_file = build_path + name
    transform_config_file(mono? ? ((ENV['configuration']||:debug).to_sym == :debug ? 'MerlinMono' : 'MonoRL' ) : 'Merlin', source, config_file)
  end

  def method_missing(name, *args)
    @targets[name.to_sym] = *args
  end
end