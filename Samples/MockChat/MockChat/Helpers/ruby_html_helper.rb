

module System::Web::Mvc::IronRuby::Helpers

  class RubyHtmlHelper

    def menu_link(text, url, key, route_value_key=:controller)
      if key.to_s.underscore == view_context.route_data.values[route_value_key].underscore
        "<li class='current_page_item'><a href='#{url}'>#{text}</a></li>"
      else
        "<li><a href='#{url}'>#{text}</a></li>"
      end
    end

    def login_menu_link(login_text="Log in", logout_text="Log out", login_action=:log_on, logout_action=:log_off, controller=:account)
      text, act = view_context.controller.is_authenticated? ? [logout_text, logout_action] : [login_text, login_action]
      menu_link text, "/#{controller}/#{act}", controller
    end

    def format_chat_body(chat_body)
      encode(chat_body).gsub("\n", "<br />")
    end

  end

end