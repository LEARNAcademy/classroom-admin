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
class Student < ApplicationRecord
  attr_accessor :email

  belongs_to :cohort

  belongs_to :user
  accepts_nested_attributes_for :user

  has_many :assessments, dependent: :destroy
  accepts_nested_attributes_for :assessments, allow_destroy: true

  before_validation :invite_user, on: :create
  after_create :create_assessments

  def invite_user
    unless self.user && User.find_by(email: self.email)
      self.user = User.build(email: self.email, name: self.student_name, admin: false)
    end
  end

  def create_assessments
    (1..6).map do |i|
      Assessment.create({student_id: id, week: i, comprehension: 0, status: 0, reviewer: "N/A", notes: "N/A"})
    end
  end

  validates :absences, presence: true, numericality: {in: 0..10}
  validates :student_name, presence: true, length: {in: 3..20}, format: {with: /\A[a-zA-Z]*\z/}
  validates :cohort_id, presence: true, numericality: true
  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :students, partial: "students/index", locals: {student: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :students, target: dom_id(self, :index) }
end
