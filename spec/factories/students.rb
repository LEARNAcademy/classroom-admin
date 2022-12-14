# == Schema Information
#
# Table name: students
#
#  id           :bigint           not null, primary key
#  absences     :integer
#  email        :string
#  student_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cohort_id    :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_students_on_cohort_id  (cohort_id)
#  index_students_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (cohort_id => cohorts.id)
#
FactoryBot.define do
  factory :student do
    cohort { FactoryBot.create(:cohort) }
    student_name { "Don" }
    absences { 0 }
    email { "testStudent@email.com" }
  end
end
