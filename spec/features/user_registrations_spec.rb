require 'spec_helper'

describe "user registration" do
  it "allows new users to register with an email address and password" do
    visit "/users/sign_up"

    fill_in "Email",                          :with => "jbhatab@example.com"
    fill_in 'Username',                       :with => 'jbhatab'
    find('.js-password').set 'ilovegrapes'
    find('.js-password-confirmation').set 'ilovegrapes'

    click_button "Sign up"

    page.should have_content("Welcome! You have signed up successfully.")
  end

end
