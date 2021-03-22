# We need two methods in our User model: an encrypt_password()
# method for when a user signs up and an authenticate() method for when a user signs in. Here’s our user.rb model with our

class User < ApplicationRecord
  attr_accessor :password

  # (?=.{8,})          # Must contain 8 or more characters
  # (?=.*\d)           # Must contain a digit
  # (?=.*[a-z])        # Must contain a lower case character
  # (?=.*[A-Z])        # Must contain an upper case character
  # (?=.*[[:^alnum:]]) # Must contain a symbol

  PASSWORD_FORMAT = /\A
    (?=.{8,})
    (?=.*\d)
    (?=.*[a-z])
    (?=.*[A-Z])
    (?=.*[[:^alnum:]])
  /x

  validates :password,
    presence: true,
    length: { maximum: 40 },
    format: { with: PASSWORD_FORMAT },
    confirmation: true,
    on: :create

  validates :email, presence: true, uniqueness: true

  validates :username, presence: true, uniqueness: {case_sensitive: false}

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