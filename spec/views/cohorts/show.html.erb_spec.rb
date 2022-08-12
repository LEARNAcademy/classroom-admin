require "rails_helper"

RSpec.describe "cohorts/show", type: :view do
  before(:each) do
    @cohort = assign(:cohort, Cohort.create!(
      cohort_name: "Cohort Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Cohort Name/)
  end
end
