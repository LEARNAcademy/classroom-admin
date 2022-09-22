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
require 'rails_helper'

RSpec.describe Cohort, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
