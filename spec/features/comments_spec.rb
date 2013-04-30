require 'spec_helper'

describe "comments" do
  it "allow user to add comments" do
    user = FactoryGirl.create(:user)
    festival = FactoryGirl.create(:festival)

    visit "/users/login"

    fill_in "Login",    :with => "jbhatab@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

    page.should have_content("Signed in successfully.")

    visit(festival_path(festival))

    fill_in "Title",    :with => "Title"
    fill_in "Comment", :with => "Commment-checker-content"

    click_button 'Create Comment'

    page.should have_css('.comment-container')

    click_link 'Cool'

    page.should have_content("You can't vote on your own comment
")
    click_link 'Delete Comment'

    save_and_open_page

    page.should have_no_content('Commment-checker-content')

  end

  it "allow comment creation if not logged in" do
    festival = FactoryGirl.create(:festival)

    visit(festival_path(festival))

    fill_in "Title",    :with => "Title"
    fill_in "Comment", :with => "Commment-checker-thing"

    click_button 'Create Comment'

    page.should have_content(' Anonymous')


  end

  it "not allow voting if not logged in" do
    festival = FactoryGirl.create(:festival)

    visit(festival_path(festival))

    fill_in "Title",    :with => "Title"
    fill_in "Comment", :with => "Commment-checker-thing"

    click_button 'Create Comment'

    click_link 'Cool'

    current_path.should eq('/users/login')

    visit(festival_path(festival))

    click_link 'Lame'

    current_path.should eq('/users/login')


  end

  it "allow voting if logged in" do
    user = FactoryGirl.create(:user)
    festival = FactoryGirl.create(:festival)

    visit(festival_path(festival))

    fill_in "Title",    :with => "Title"
    fill_in "Comment", :with => "Commment-checker-thing"

    click_button 'Create Comment'

    visit "/users/login"

    fill_in "Login",    :with => "jbhatab@example.com"
    fill_in "Password", :with => "ilovegrapes"

    click_button "Sign in"

    visit(festival_path(festival))


    click_link 'Cool'

    current_path.should eq(festival_path(festival))

    click_link 'Lame'

    current_path.should eq(festival_path(festival))

  end
end
