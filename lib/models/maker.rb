require 'bcrypt'

class Maker
  include DataMapper::Resource

  property :id, Serial
  property :email, String, unique: true, message: "This email address is already taken"
  property :name, String
  property :username, String, unique: true, message: "This username is already taken"
  property :password_digest, Text

  attr_reader :password
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
    maker = first(username: username)
    if maker && BCrypt::Password.new(maker.password_digest) == password
      maker
    end
  end
end