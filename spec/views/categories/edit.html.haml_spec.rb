require 'spec_helper'

describe "categories/edit.html.haml" do
  before(:each) do
    @category = assign(:category, stub_model(Category,
      :name => "MyString",
      :group_id => 1,
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    ))
  end

  it "renders the edit category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => categories_path(@category), :method => "post" do
      assert_select "input#category_name", :name => "category[name]"
      assert_select "input#category_group_id", :name => "category[group_id]"
      assert_select "input#category_parent_id", :name => "category[parent_id]"
      assert_select "input#category_lft", :name => "category[lft]"
      assert_select "input#category_rgt", :name => "category[rgt]"
    end
  end
end
