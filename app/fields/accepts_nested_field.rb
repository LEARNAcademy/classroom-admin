require "administrate/field/base"

class AcceptsNestedField < Administrate::Field::Base
  def to_s
    data
  end
end
