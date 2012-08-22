class ContactusController < ApplicationController
  skip_before_filter :authorize

  def index
    @message = Message.new
  end

  def send_message
    @message = Message.new(params[:message])
    if @message.valid?
      Contact.contact_message(@message).deliver
      flash[:notice] = 'Message sent, thank you for your comments'
    else
      flash[:alert] = 'Message not sent, please fill in all fields'
    end
    redirect_to contactus_path
  end
end
