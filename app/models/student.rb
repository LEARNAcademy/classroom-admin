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
class Student < ApplicationRecord
  belongs_to :cohort
  has_many :assessments, dependent: :destroy
  accepts_nested_attributes_for :assessments, allow_destroy: true

  after_create :create_assessments

  def create_assessments
    (1..6).map do |i|
      Assessment.create({student_id: id, week: i, comprehension: 0, status: 0, reviewer: "N/A", notes: "N/A"})
    end
  end

  validates :absences, presence:true
  validates :student_name, presence: true
  validates :cohort_id, presence: true
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :students, partial: "students/index", locals: {student: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :students, target: dom_id(self, :index) }
end
