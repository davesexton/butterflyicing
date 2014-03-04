require 'test_helper'

class ContactTest < ActionMailer::TestCase
  test 'message' do
    msg = Message.new
    msg.email = 'test@test.com'
    msg.name = 'My Name'
    msg.message = 'hi xyz'
    mail = Contact.contact_message(msg)
    assert_equal 'Contact Message from Butterflyicing', mail.subject
    assert_equal ['to@example.com'], mail.to
    assert_equal ['from@example.com'], mail.from
    #assert_match 'Comment recieved through Butterfly Icing website', mail.body.encoded
    #assert_match 'My Name', mail.body.encoded
    #assert_match 'test@test.com', mail.body.encoded
    #assert_match 'hi xyz', mail.body.encoded
  end

end
