# == Schema Information
#
# Table name: students
#
#  id           :bigint           not null, primary key
#  absences     :integer
#  student_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cohort_id    :bigint           not null
#
# Indexes
#
#  index_students_on_cohort_id  (cohort_id)
#
# Foreign Keys
#
#  fk_rails_...  (cohort_id => cohorts.id)
#
require 'rails_helper'

RSpec.describe Student, type: :model do
  it "has no students to begin with" do
    expect(Student.count).to eq 0
  end
end
