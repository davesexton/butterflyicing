require 'test_helper'

class ContactTest < ActionMailer::TestCase
  test "message" do
    mail = Contact.message
    assert_equal "Message", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
