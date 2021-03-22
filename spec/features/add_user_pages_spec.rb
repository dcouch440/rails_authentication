require 'rails_helper'

describe 'the add user process' do
  it 'adds a new user' do
    visit '/'
    click_link 'Sign up'
    fill_in 'user_username', :with => 'test_user'
    fill_in 'user_email', :with => 'test_email@email.com'
    fill_in 'user_password', :with => 'test_P@ssw0rd'
    fill_in 'user_password_confirmation', :with => 'test_P@ssw0rd'
    click_on 'Sign Up'
    expect(page).to have_content "You've successfully signed up!"
  end
end
