include Mindscape::LightSpeed
include Mindscape::LightSpeed::Logging
include Mindscape::LightSpeed::Querying

unless defined? $context

  ph_path = defined?(System::Web::HttpContext) ? System::Web::HttpContext.current.request.physical_application_path : Dir.pwd

  #setup context
  $context = LightSpeedContext.of(MockChatUnitOfWork).new
  $context.connection_string = "Data Source=#{ph_path}\\App_Data\\mockchat_dev.sqlite3"
  $context.data_provider = DataProvider.SQLite3
  $context.identity_method = IdentityMethod.identity_column
  $context.pluralize_table_names = true
  $context.logger = TraceLogger.new
end

module Lightspeed

  LSEntity = Mindscape::LightSpeed::Entity.to_a.first

  module ControllerHelpers

    def uow_scope
      @uow_scope ||= PerRequestUnitOfWorkScope.of(MockChatUnitOfWork).new($context)
    end

    def collect_errors(entity, prefix="")
      entity.errors.each do |error|
        prop = prefix.nil? || prefix.empty? ? error.property_name.underscore : "#{prefix}.#{error.property_name.underscore}"
        model_state.add_model_error prop, error.error_message
      end
    end

  end
  


  module Finder

    # Evaluate the block to build a query expression
    def where(&b)
      RubyQueryExpression.evaluate b
    end

    class RubyQueryExpression

      # Represents the attribute path that needs to be added to the where clause
      attr_reader :attribute

      # The operator to use for this part of the where clause
      attr_reader :operator

      # The value that needs to be compared to.
      attr_reader :value

      # builds a new +RubyPathExpression+ instance
      def build(&b)
        instance_eval b unless b.nil?
      end

      # Evaluate the block to build a query expression
      def self.evaluate(&b)
        new.build(&b)
      end

      # Adds an attribute name to this where clause
      def a(name)
        @attribute = name.to_s.to_clr_string
        @attr_expression = LSEntity.attribute(attribute)
        self
      end

      # Creates either a equals, a between or a in operator.
      # it creates an +IN+ comparison when the value provided is an Array or IEnumerable implementation
      # it creates a +BETWEEN+ comparison when the value provided is a Range
      # in all other cases it creates an +EQUALS+ comparison
      def ==(val)
        case val
          when Range
            between val.min, val.max
          when String
            @operator = RelationalOperator.equal_to
            set val
          when Enumerable, System::Collections::IEnumerable
            @operator = RelationalOperator.in
            set val
          else
            @operator = RelationalOperator.equal_to
            set val
        end
      end
      alias_method :equals, :==
      alias_method :eql, :==
      alias_method :equal_to, :==

      # Creates a +BETWEEN+ comparison
      def between(min, max)
        @operator = RelationalOperator.between
        set min, max
      end

      # Creates an +IN+ comparison
      def in(values)
        @operator = RelationalOperator.in
        set *values
      end

      # Creates a +LIKE+ comparison
      def like(val)
        @operator = RelationalOperator.like
        set val
      end

      # Creates a +greater than+ comparison
      def >(val)
        @operator = RelationalOperator.greater_than
        set val
      end
      alias_method :greater_than, :>

      # Creates a +greater than or equal to+ comparison
      def >=(val)
        @operator = RelationalOperator.greater_than_or_equal_to
        set val
      end
      alias_method :greater_than_or_equal_to, :>=

      # Creates a +less than+ comparison
      def <(val)
        @operator = RelationalOperator.less_than
        set val
      end
      alias_method :less_than, :<

      # Creates a +less than or equal to+ comparison
      def <=(val)
        @operator = RelationalOperator.less_than_or_equal_to
        set val
      end
      alias_method :less_than_or_equal_to, :<=

      # Creates a +not equal to+ comparison
      def not_eql(val)
        @operator = RelationalOperator.not_equal_to
        set val
      end
      alias_method :not_equal_to, :not_eql
      alias_method :not=, :not_eql
      alias_method :inequal_to, :not_eql

      # Builds a +SQL LOWER+ expression
      def lower
        @attr_expression.lower
      end

      # Builds a +SQL UPPER+ expression
      def upper
        @attr_expression.upper
      end

      # Builds a +SQL EXISTS+ expression
      def exists
        @attr_expression.exists
      end

      # Creates an +OR+ expression
      def |(val)
        LogicalExpression.create @attr_expression, LogicalOperator.or, val
      end

      # Creates an +AND+ expression
      def &(val)
        LogicalExpression.create @attr_expression, LogicalOperator.and, val
      end

      # Constructs the CLR version of the expression
      def to_expr
        @attr_expression = PathExpression.build_expression @attr_expression, operator, value
      end

      private

      def set(*val)
        @value = val.collect { |v| LiteralExpression.new(v) }
        to_expr
      end
    end
  end

end

module System::Web::Mvc::IronRuby::Helpers

  class RubyHtmlHelper

    def drop_down_list(name, list=[], option_label=nil, html_attributes={})
      options, html_attrs = [], {}

      html_attrs = option_label if option_label.is_a? Hash
      html_attrs ||= html_attributes
      option_label, list = list, [] if list.is_a?(String)

      options << "<option value=\"\">#{option_label}</option>" unless option_label.nil? || option_label.empty?
      options += list.collect do |item|
        "<option value=\"#{item[:value]}\" #{"selected=\"selected\"" if item[:selected]}>#{item[:text]}</option>"
      end

      ddl_id = name.gsub /\./, '_'
      attrs = html_attrs.collect {|k, v| "#{k}=\"#{v}\"" }.join(" ")
      <<-HTML
<select id="#{ddl_id}" name="#{name}\" #{attrs}>
  #{options.join("\n")}
</select>
      HTML
    end

  end

end