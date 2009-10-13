# compressed version of magic - do not modify

# run rake compressor in project http://github.com/thbar/magic/tree/master to recreate

# content for lib/magic/classifier.rb

# ability to transform from snake_case (ruby) to CamelCase (.Net)
# maybe there is an IronRuby built-in we could rely on for that ?
module Classifier
  def classify(string)
    string.gsub(/(^|_)(.)/) { $2.upcase } # simplified version of Rails inflector
  end
end

# content for lib/magic/instanciator.rb

# disabled: require 'magic/classifier'

# internal sugar to instanciate a given CLR type - apart from enum handling, the code is not CLR specific
module Instanciator
  include Classifier

  # if klass.property_name is a CLR enum, parse the value to translate it into the CLR enum value
  def parse_enum_if_enum(klass,property_name,value)
    type = klass.to_clr_type.get_property(classify(property_name.to_s)).property_type
    type.is_enum ? Enum.parse(type, classify(value.to_s)) : value
  end
  
  # instanciate the given class and set the properties passed as options
  # support both values and procs for options
  def build_instance_with_properties(klass,*args)
    properties = args.last.is_a?(Hash) ? args.delete_at(args.size-1) : {}
    instance = klass.new(*args)
    properties.keys.inject(instance) do |instance,k|
      v = properties[k]
      v.is_a?(Proc) ? instance.send(k,&v) : instance.send("#{k}=", parse_enum_if_enum(klass,k,v))
      instance
    end
  end

end


# content for lib/magic.rb

# disabled: require File.dirname(__FILE__) + "/magic/instanciator"
# disabled: require File.dirname(__FILE__) + "/magic/classifier"

# DSL-like object creation. Not that much .Net related, except for the Control/MenuItem specifics
# which could be extracted and made configurable. This is likely to happen.
class Magic
  include Instanciator
  include Classifier

  class << self
    def build(&description)
      self.new.instance_eval(&description)
    end
  end

  def method_missing(method,*args)
    # push stuff recursively on a stack so that we can add the item to its parents children collection
    @stack ||= []
    clazz = eval(classify(method.to_s))
    instance = build_instance_with_properties(clazz, *args)
    # add to the parent control only if it's a well known kind
    # todo - extract configurable mappings ?
    if @stack.last
      @stack.last.controls.add(instance) if (defined?(Control) && instance.is_a?(Control))
      @stack.last.menu_items.add(instance) if (defined?(MenuItem) && instance.is_a?(MenuItem))
      @stack.last.children.add(instance) if (defined?(UIElement) && instance.is_a?(UIElement))
    end
    @stack.push(instance)
    yield if block_given?
    @stack.pop
  end
end
