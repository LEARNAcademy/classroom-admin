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
require "rails_helper"

RSpec.describe Student, type: :model do
  subject(:student) { FactoryBot.create(:student) }
  it { is_expected.to be_valid }

  context "absences" do
    it "should not be less than 0" do
      student.absences = -1
      is_expected.to be_invalid
    end
    it "should not be more than 10" do
      student.absences = 11
      is_expected.to be_invalid
    end
  end

  context "student name" do
    it "should not be less than 3 letters" do
      student.student_name = "Jo"
      is_expected.to be_invalid
    end
    it "should not be more than 20 letters" do
      student.student_name = "JoJoJoJoJoJoJoJoJoJoJoJoJoJoJoJoJoJo"
      is_expected.to be_invalid
    end
    it "should not have any numbers or symbols" do
      student.student_name = "*&(a@fasdf15%"
      is_expected.to be_invalid
    end
  end
end
