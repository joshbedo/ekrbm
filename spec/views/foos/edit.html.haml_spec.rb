require 'spec_helper'

describe "foos/edit" do
  before(:each) do
    @foo = assign(:foo, stub_model(Foo,
      :bar => "MyString"
    ))
  end

  it "renders the edit foo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", foo_path(@foo), "post" do
      assert_select "input#foo_bar[name=?]", "foo[bar]"
    end
  end
end
