require File.dirname(__FILE__) + "/magic/instanciator"

# a better attempt at Windows::Forms dsl
class Magic
  include Instanciator

  class << self
    def build(&description)
      self.new.instance_eval(&description)
    end
  end

  def classify(string)
    string.gsub(/(^|_)(.)/) { $2.upcase } # simplified version of Rails inflector
  end

  def method_missing(method,*args)
    @stack ||= []
    clazz = eval(classify(method.to_s))
    control = build_instance_with_properties(clazz, *args)
    # add to the parent control - only if it is a control
    # useful to declare background_worker with the same syntax
    # todo: modify this to also handle the menu syntax
    # todo: we need some specs - mspec ? cucumber ? rspec ?
    @stack.last.controls.add(control) if (@stack.last && control.is_a?(Control))
    @stack.push(control)
    yield if block_given?
    @stack.pop
  end
end
