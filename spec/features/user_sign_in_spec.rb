require "spec_helper"

describe "user sign in" do
  it "allows users to sign in after they have registered wtih email or username" do
    user = FactoryGirl.create(:user)
    
    visit "/users/login"

    fill_in "Email or Username:",    :with => "jbhatab@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

    page.should have_content("Signed in as "+user.username)

    click_link "Sign out"

    page.should have_content("Signed out successfully.")

    visit "/users/login"

    fill_in "Email or Username:",    :with => "jbhatab"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"
    
    page.should have_content("Signed in as "+user.username)

  end
end
