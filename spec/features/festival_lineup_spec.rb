require 'spec_helper'

describe "festival lineup" do
  it "add festival to lineup" do
    user = FactoryGirl.create(:user)
    festival = FactoryGirl.create(:festival)

    visit "/users/login"

    fill_in "Login",    :with => "jbhatab@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")

    

    visit "/festivals"

    click_link 'Add To Lineup'

    current_path.should eq('/lineup')

    page.should have_content(festival.name)

    click_link festival.name

    page.should have_content('Already Added')
  end

  it "remove festival from lineup" do
    user = FactoryGirl.create(:user)
    festival = FactoryGirl.create(:festival)

    visit "/users/login"

    fill_in "Login",    :with => "jbhatab@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")

    

    visit "/festivals"

    click_link 'Add To Lineup'

    current_path.should eq('/lineup')

    click_link "Remove From Lineup"

    page.should have_no_content(festival.name)
  end
end
