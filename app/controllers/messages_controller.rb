class MessagesController < ApplicationController
  def send_message
    ActionCable.server.broadcast("messages_channel", message: params[:message])
    render json: { status: "Message sent" }, status: :ok
  end
end
