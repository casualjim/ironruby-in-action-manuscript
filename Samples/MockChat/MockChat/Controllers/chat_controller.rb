require 'authenticated_controller_base'
require 'chat_service'

class ChatController  < AuthenticatedControllerBase

  attr_accessor :chat_service

  def chat_service
    @chat_service ||= ChatService.new(uow_scope)
  end
  
  def index
    @session = chat_service.current_subject || ChatSession.new
    @messages = chat_service.get_last_30_messages #get_all_messages

    return view('index', 'layout') unless request.ajax?
    view('_chat_list', '')
  end
  alias_method :last_30_messages, :index

  def add_message
    message = ChatMessage.create_from_hash :body => params[:message].gsub(/<\/?[^>]*>/,  ""), :created_by => current_user
    chat_service.save message
    redirect_to_action :index  unless request.ajax?
    index
  end

  def change_subject
    chat_service.change_subject params[:update_value], current_user
    content(chat_service.current_subject.name)
  end

end