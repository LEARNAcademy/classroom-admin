# == Schema Information
#
# Table name: assessments
#
#  id            :bigint           not null, primary key
#  comprehension :integer
#  notes         :text
#  reviewer      :string
#  status        :integer
#  week          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  student_id    :bigint           not null
#
# Indexes
#
#  index_assessments_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
FactoryBot.define do
  factory :assessment do
    student { FactoryBot.create(:student) }
    week { student.assessments[0].week }
    status { student.assessments[0].status }
    comprehension { student.assessments[0].comprehension }
    reviewer { student.assessments[0].reviewer }
    notes { student.assessments[0].notes }
  end
end
