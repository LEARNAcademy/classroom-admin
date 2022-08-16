require "rails_helper"

RSpec.describe "cohorts/edit", type: :view do
  before(:each) do
    @cohort = assign(:cohort, Cohort.create!(
      cohort_name: "MyString"
    ))
  end

  it "renders the edit cohort form" do
    render

    assert_select "form[action=?][method=?]", cohort_path(@cohort), "post" do
      assert_select "input[name=?]", "cohort[cohort_name]"
    end
  end
end
