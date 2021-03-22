# We need two methods in our User model: an encrypt_password()
# method for when a user signs up and an authenticate() method for when a user signs in. Here’s our user.rb model with our

class User < ApplicationRecord
  attr_accessor :password

  validates_confirmation_of :password
  validates :email, :presence => true, :uniqueness => true

  before_save :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(email, password)

    user = User.find_by "email = ?", email
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end

  end
end