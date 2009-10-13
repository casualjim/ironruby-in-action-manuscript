module Instanciator

  # instanciate the given class and set the properties passed as options
  # support both values and procs for options
  # todo - detect if the property is an enum - and allow a symbol to be passed then ?
  def build_instance_with_properties(klass,properties={})
    instance = klass.new
    properties.each do |k,v|
      if v.is_a?(Proc)
        instance.send(k) { v.call }
      else
        instance.send("#{k}=",v)
      end
    end
    instance
  end

end
