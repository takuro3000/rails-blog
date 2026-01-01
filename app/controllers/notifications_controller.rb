class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[ mark_as_read ]

  def index
    @notifications = current_user.notifications.recent.includes(notifiable: [:user, :post])
  end

  def mark_as_read
    @notification.mark_as_read!
    redirect_to @notification.notifiable.post, notice: "Notification marked as read."
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(read_at: Time.current)
    redirect_to notifications_path, notice: "All notifications marked as read."
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end

