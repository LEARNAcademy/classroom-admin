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
class Assessment < ApplicationRecord
  belongs_to :student
  enum status: {Unassigned: 0, Pending: 1, Complete: 2, Incomplete: 3}, _prefix: true, _default: :unassigned
  enum comprehension: {Unassigned: 0, Complete: 1, Novice: 2, "Advanced Beginner": 3, Competent: 4}, _suffix: true, _default: :unassigned

  validates :comprehension, presence: true
  validates :notes, presence: true
  validates :reviewer, presence: true
  validates :status, presence: true
  validates :week, presence: true, numericality: {in: 1..6}
  validates :student_id, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :assessments, partial: "assessments/index", locals: {assessment: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :assessments, target: dom_id(self, :index) }
end
