require 'rails_helper'

describe User do
  it { should validate_presence_of :username }
  it { should (validate_uniqueness_of :username).case_insensitive }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_confirmation_of :password }
  it { should validate_presence_of :password }

  it "should validate a password to specifications" do
    interval = 0

    [
      'Ban4nn@',
      'Bannann@',
      'BANNANN4444@',
      'bannanadsf@4',
      'Banana444',
      'Bananna@400400'

    ].each do |password|

      User.create(
        username: "TEST_USER_#{interval}",
        email: "TEST_EMAIL#{interval}@gmail.com",
        password: password,
        password_confirmation: password
      )

      interval += 1

    end
    expect(User.all.count).to eq 1
  end
end