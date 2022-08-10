require 'rails_helper'

RSpec.describe "cohorts/index", type: :view do
  before(:each) do
    assign(:cohorts, [
      Cohort.create!(
        cohort_name: "Cohort Name"
      ),
      Cohort.create!(
        cohort_name: "Cohort Name"
      )
    ])
  end

  it "renders a list of cohorts" do
    render
    assert_select "tr>td", text: "Cohort Name".to_s, count: 2
  end
end
