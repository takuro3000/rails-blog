class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(comment)
    # 投稿者に通知を作成
    Notification.create!(
      user: comment.post.user,
      notifiable: comment,
      notification_type: "comment"
    )
  end
end

