# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/your_post_is_commented
  def your_post_is_commented
    NotificationsMailer.your_post_is_commented
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/your_comment_is_replied
  def your_comment_is_replied
    NotificationsMailer.your_comment_is_replied
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/you_are_mentioned
  def you_are_mentioned
    NotificationsMailer.you_are_mentioned
  end

end
