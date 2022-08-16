require "test_helper"

class NotificationsMailerTest < ActionMailer::TestCase
  test "your_post_is_commented" do
    mail = NotificationsMailer.your_post_is_commented
    assert_equal "Your post is commented", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "your_comment_is_replied" do
    mail = NotificationsMailer.your_comment_is_replied
    assert_equal "Your comment is replied", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "you_are_mentioned" do
    mail = NotificationsMailer.you_are_mentioned
    assert_equal "You are mentioned", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
