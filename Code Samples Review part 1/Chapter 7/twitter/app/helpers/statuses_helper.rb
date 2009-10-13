module StatusesHelper
  def link_with_login(status, text=nil, options={})
    opts = options.collect {|k, v| "#{k}=#{v}"}.join(" ")
    "<a href=\"/users/show/#{status.user.login}\" #{opts}>#{text.nil? || text.empty? ? status.user.login : text}</a>"
  end
end
