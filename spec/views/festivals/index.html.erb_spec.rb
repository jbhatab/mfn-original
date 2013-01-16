require 'spec_helper'

describe "festivals/index" do
  before(:each) do
    assign(:festivals, [
      stub_model(Festival,
        :name => "Name",
        :city => "City",
        :state => "State",
        :lat => 1.5,
        :long => 1.5,
        :genre => "Genre",
        :website => "Website"
      ),
      stub_model(Festival,
        :name => "Name",
        :city => "City",
        :state => "State",
        :lat => 1.5,
        :long => 1.5,
        :genre => "Genre",
        :website => "Website"
      )
    ])
  end

  it "renders a list of festivals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Genre".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
  end
end
