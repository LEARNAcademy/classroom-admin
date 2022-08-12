require "rails_helper"

RSpec.describe "cohorts/new", type: :view do
  before(:each) do
    assign(:cohort, Cohort.new(
      cohort_name: "MyString"
    ))
  end

  it "renders new cohort form" do
    render

    assert_select "form[action=?][method=?]", cohorts_path, "post" do
      assert_select "input[name=?]", "cohort[cohort_name]"
    end
  end
end
