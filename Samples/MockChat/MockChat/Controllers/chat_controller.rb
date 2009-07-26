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
    view 'index', 'layout'
  end
  alias_method :last_30_messages, :index

  def add_message
    message = ChatMessage.create_from_hash :body => params[:message], :created_by => current_user
    chat_service.save message
    @messages = chat_service.get_last_30_messages
    @session = chat_service.current_subject 
    view 'index', 'layout'    
  end

  def change_session
    chat_service.change_subject params[:subject]
  end

end