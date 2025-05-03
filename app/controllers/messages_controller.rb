class MessagesController < ApplicationController
  def send_message 
    # Sends a message to a given emails list
    message = params[:message]
    emails = params[:emails]

    # Validation
    if message.blank? || emails.blank? || !emails.is_a?(Array) || emails.empty?
      render json: { error: "'mensagem' e 'emails' são obrigatórios. E 'emails' deve ser um array" }, status: :bad_request
      return
    end

    # Jobs Queue
    emails.each do |email|
        SendEmailJob.perform_async(message, email)
    end

    render json: { message: "Jobs enfileirados para o envio de email" }, status: :ok
  end
end
