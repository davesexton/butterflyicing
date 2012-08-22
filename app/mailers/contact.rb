class Contact < ActionMailer::Base
  default from: APP_CONFIG['email_from']

  def contact_message(message)

    @greeting = "Hi"
    @message = message

    mail subject: 'Contact Message from Butterflyicing',
         to: APP_CONFIG['email_to']

  end
end
