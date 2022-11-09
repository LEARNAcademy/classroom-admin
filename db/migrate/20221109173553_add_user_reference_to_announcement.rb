class AddUserReferenceToAnnouncement < ActiveRecord::Migration[7.0]
  def change
    add_reference :announcements, :user, index: true, foreign_key: true
  end
end
