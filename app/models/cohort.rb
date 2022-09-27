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
class Cohort < ApplicationRecord
  has_many :students, dependent: :destroy
  alias_attribute :active_storage_attachments, :student_csv
  has_one_attached :student_csv, dependent: :destroy
  accepts_nested_attributes_for :students, allow_destroy: true

  validates :cohort_name, length: (4..10),presence: true
  validates :cohort_year, presence: true, numericality: { in: 2000..2100}
  validates_uniqueness_of :cohort_name, scope: %i[cohort_year]
  
  

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :cohorts, partial: "cohorts/index", locals: { cohort: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :cohorts, target: dom_id(self, :index) }
end
