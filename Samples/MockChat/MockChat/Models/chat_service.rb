require 'mock_chat_repository'

class ChatService

  attr_reader :repo

  def initialize(uow_scope)
    @repo = MockChatRepository.new uow_scope
  end

  def current_subject
    @current_subject ||= repo.find_current_subject
  end

  def get_all_messages
    repo.messages
  end

  def get_last_30_messages
    repo.find_last_30_messages
  end

  def save(message)
    message.chat_session ||= current_subject
    repo.save message
  end

  def change_subject(subject, created_by)
    subj = ChatSession.create_from_hash :name => subject, :created_by => created_by
    subj.room = repo.find_current_room
    repo.save subj
    @current_subject = subj
  end

  def search(search_term)

  end
  
end