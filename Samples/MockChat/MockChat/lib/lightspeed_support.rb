include Mindscape::LightSpeed
include Mindscape::LightSpeed::Logging

unless defined? $context

  ph_path = System::Web::HttpContext.current.request.physical_application_path
  
  #setup context
  $context = LightSpeedContext.of(MockChatUnitOfWork).new
  $context.connection_string = "Data Source=#{ph_path}\\App_Data\\mockchat_dev.sqlite3"
  $context.data_provider = DataProvider.SQLite3
  $context.identity_method = IdentityMethod.identity_column
  $context.pluralize_table_names = true
  $context.logger = TraceLogger.new
end

module Lightspeed

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