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
FactoryBot.define do
  factory :cohort do
    cohort_name { "Charlie" }
    cohort_year { 2022 }
  end
end
