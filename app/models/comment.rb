class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :body, presence: true

  after_create_commit :notify_post_owner

  private

  def notify_post_owner
    CreateNotificationJob.perform_later(self) if user != post.user
  end
end
