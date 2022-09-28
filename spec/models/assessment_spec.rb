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
require "rails_helper"

RSpec.describe Assessment, type: :model do
  subject(:assessment) { FactoryBot.create(:assessment) }
  it { is_expected.to be_valid }

  context "comprehension" do
    it "should not be less than 0" do
      assessment.comprehension = -1
      is_expected.to be_invalid
    end
    it "should not be greater than 4" do
      assessment.comprehension = 5
      is_expected.to be_invalid
    end
  end

  context "week" do
    it "should not be less than 1" do
      assessment.week = 0
      is_expected.to be_invalid
    end
    it "should not be greater than 6" do
      assessment.week = 7
      is_expected.to be_invalid
    end
  end
end
