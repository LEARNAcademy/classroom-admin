class AnnouncementsController < ApplicationController
  before_action :mark_as_read, if: :user_signed_in?

  def index
    if current_user&.admin?
      @pagy, @announcements = pagy(Announcement.order(published_at: :desc))
    else
      redirect_to "/404"
    end
  end

  private

  def mark_as_read
    current_user.update(announcements_read_at: Time.zone.now)
  end
end
