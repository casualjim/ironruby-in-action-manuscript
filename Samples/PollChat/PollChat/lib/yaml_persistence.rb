require 'yaml'

module YamlPersistence

  def save(attribs={})
    update(attribs)
    self.class.save self
  end

  def delete
    self.class.delete self
  end

  def update(attribs={})
    attribs.each_pair do |k, v|
      self.send("#{k}=", v) if self.respond_to?("#{k}=".to_sym)
    end
  end

  module ClassMethods

    def key(attrib)
      @key = attrib
    end

    def model_name
      self.to_s.underscore
    end

    def store_path
      "#{MVC_ROOT}/AppData/#{model_name}"
    end

    def save(mod)
      pth = store_filepath mod.send(@key)
      File.open(pth, 'w') { YAML.dump(mod) }
      nil
    end

    def delete(mod)
      pth = store_filepath mod.send(@key)
      File.rm pth if File.exist? pth
      mod = nil
    end

    def store_filepath (key)
      "#{store_path}/#{key}.yml"
    end

    def find_one(key)
      pth = store_filepath key
      YAML.load(File.read(pth)) if File.exist?(pth)
    end

    def find_all
      Dir.glob(store_path + "/*.yml").collect { |pth| YAML.load(File.read(pth)) }.compact
    end

    def find(*args, &filter)
      coll = nil
      coll = find_all if args.empty?
      coll = [find_one(args.last)] if args.size == 1
      coll = Dir.glob(store_path + "/{#{args.join(',')}}.yml") unless coll
      coll.select(&filter).compact
    end
    
  end

  def self.included(base)
    base.extend ClassMethods
  end

end