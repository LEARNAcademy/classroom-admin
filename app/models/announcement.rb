# == Schema Information
#
# Table name: announcements
#
#  id           :bigint           not null, primary key
#  kind         :string
#  published_at :datetime
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Announcement < ApplicationRecord
  TYPES = %w[new fix improvement update]

  has_rich_text :description

  validates :kind, :title, :description, :published_at, presence: true

  after_initialize :set_defaults

  has_noticed_notifications model_name: "Notification"

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications

  private

  def notify_recipient
    NewAnnouncementNotification.with(announcement: self).deliver_later(User.all)
  end

  def cleanup_notifications
    notifications_as_announcement.destroy_all
  end

  def set_defaults
    self.published_at ||= Time.current
  end
end
