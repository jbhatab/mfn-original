require 'spec_helper'

describe "topics/new" do
  before(:each) do
    assign(:topic, stub_model(Topic,
      :name => "MyString",
      :description => "MyText",
      :user => nil,
      :forum => nil
    ).as_new_record)
  end

  it "renders new topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", topics_path, "post" do
      assert_select "input#topic_name[name=?]", "topic[name]"
      assert_select "textarea#topic_description[name=?]", "topic[description]"
      assert_select "input#topic_user[name=?]", "topic[user]"
      assert_select "input#topic_forum[name=?]", "topic[forum]"
    end
  end
end
