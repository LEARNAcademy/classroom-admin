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
  pending "add some examples to (or delete) #{__FILE__}"
end
