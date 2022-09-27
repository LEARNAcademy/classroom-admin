# == Schema Information
#
# Table name: cohorts
#
#  id          :bigint           not null, primary key
#  cohort_name :string
#  cohort_year :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Cohort, type: :model do
  it "has no cohorts to begin with" do
    expect(Cohort.count).to eq 0
  end
end
