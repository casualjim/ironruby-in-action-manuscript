require 'digest/sha2'
require 'openssl'
require 'mock_chat_repository'

class UserService

  attr_reader :repo

  def initialize(uow_scope)
    @repo = MockChatRepository.new(uow_scope)
  end

  def min_password_length
    6
  end

  def get_all
    repo.users
  end

  def get_one(id)
    repo.find_user_by_id(id)
  end

  def get_one_by_username(username)
    repo.find_user_by_username username
  end

  def save(user)
    set_password user, user.password if user.entity_state == EntityState.new
    repo.save user
  end

  def remove(id)
    user = repo.get_user_by_id id
    repo.remove user unless user.nil?
  end

  def validate_user(user_name, password)
    user = get_one_by_username user_name
    !user.nil? && user.password == create_hash(password, user.salt)
  end

  def change_password(user_name, old_password, new_password)
    current_user = get_one_by_username user_name
    if current_user.password == create_hash(old_password, current_user.salt)
      set_password current_user, new_password
      save current_user
    else
      current_user.errors.add "Password", "There was a problem changing your password"
    end
  end

  private

  def set_password(user, passwd)
    user.salt = create_salt
    user.password = create_hash passwd, user.salt
  end

  def create_salt
    [OpenSSL::Random.random_bytes(64)].pack("m*").delete("\n")
  end

  def create_hash(password, salt)
    Digest::SHA512.hexdigest("#{password}:#{salt}")
  end
end