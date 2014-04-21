require 'spec_helper'

describe "foos/new" do
  before(:each) do
    assign(:foo, stub_model(Foo,
      :bar => "MyString"
    ).as_new_record)
  end

  it "renders new foo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", foos_path, "post" do
      assert_select "input#foo_bar[name=?]", "foo[bar]"
    end
  end
end
