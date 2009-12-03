require 'digest/sha2'
require 'openssl'

class User

  include YamlRepository

  attr_accessor :name, :username, :email, :password, :salt

  key :username

  def save(attribs={})
    update attribs
    set_password(attribs[:password]) if self.salt.to_s.empty?
    User.save self
  end

  private

  def set_password(pw)
    user.salt = create_salt
    user.password = create_hash pw, user.salt
  end

  def create_salt
    [OpenSSL::Random.random_bytes(64)].pack("m*").delete("\n")
  end

  def create_hash(password, salt)
    Digest::SHA512.hexdigest("#{password}:#{salt}")
  end
end