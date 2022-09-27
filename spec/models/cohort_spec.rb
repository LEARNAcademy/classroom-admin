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
  subject(:cohort) { FactoryBot.create(:cohort)}
  it { is_expected.to be_valid }

  context "length of name" do
    it "will be invalid if cohort name is greater than 10" do
      cohort.cohort_name = "12345Charlie"
      is_expected.to be_invalid
    end
    it "will be invalid if cohort name is less than 4" do
      cohort.cohort_name = "Cha"
      is_expected.to be_invalid
    end
  end

  context "year" do
    it "will be invalid if cohort year is not an integer" do
      cohort.cohort_year = "TwentyTwentyTwo"
      is_expected.to be_invalid
    end
    it "will be invalid if cohort year is less than 2000" do
      cohort.cohort_year = 1999
      is_expected.to be_invalid
    end
    it "will be invalid if cohort_year is greater than 2100" do
      cohort.cohort_year = 2101
      is_expected.to be_invalid
    end
  end

end
