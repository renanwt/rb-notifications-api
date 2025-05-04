require 'dotenv/load'
require 'sendgrid-ruby'

class SendEmailJob
  include Sidekiq::Worker

  def perform(message, email)
    # Configure sua chave de API do SendGrid
    client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    from = SendGrid::Email.new(email: ENV['SENDGRID_SINGLE_SENDER_EMAIL'])
    to = SendGrid::Email.new(email: email)
    subject = 'Pluga Teste - Desafio Renan'
    content = SendGrid::Content.new(type: 'text/plain', value: message)
    mail = SendGrid::Mail.new(from, subject, to, content)

    begin
      response = client.client.mail._('send').post(request_body: mail.to_json)
      if response.status_code.to_i != 202
        Rails.logger.error "Erro ao enviar e-mail para #{email}: #{response.body}"
      end
    rescue StandardError => e
      Rails.logger.error "Erro ao tentar enviar e-mail: #{e.message}"
    end
  end
end
