# To deliver this notification:
#
# NewAnnouncementNotification.with(post: @post).deliver_later(current_user)
# NewAnnouncementNotification.with(post: @post).deliver(current_user)

class NewAnnouncementNotification < ApplicationNotification
  # Database delivery is already added in ApplicationNotification
  deliver_by :action_cable, format: :to_websocket, channel: "NotificationChannel"

  # Add your delivery methods
  #
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # `message` and `url` are used for rendering in the navbar

  def message
    @announcement = Announcement.find(params[:announcement][:id])
    @account_user = AccountUser.find_by(id: record.account_id)
    @user = User.find_by(id: @account_user.user_id)
    "#{@announcement.title.titleize} created by #{@user.name} "
  end

  def url
    # You can use any URL helpers here such as:
    # post_path(params[:post])
    announcements_path
  end

  # Include account_id to make sure notification only triggers if user is signed in to that account
  def to_websocket
    {
      account_id: record.account_id,
      html: ApplicationController.render(partial: "notifications/notification", locals: {notification: record})
    }
  end
end
