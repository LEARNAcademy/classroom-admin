class AddUserReferencesToStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :user, index: true
  end
end
