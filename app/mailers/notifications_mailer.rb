class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.your_post_is_commented.subject
  #
  def your_post_is_commented(user)
    @greeting = "Hi"

    mail to: user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.your_comment_is_replied.subject
  #
  def your_comment_is_replied(user)
    @greeting = "Hi"

    mail to: user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.you_are_mentioned.subject
  #
  def you_are_mentioned(user)
    @greeting = "Hi"

    mail to: user.email
  end
end
