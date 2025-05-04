class WelcomeController < ApplicationController
  def index
    render plain: "Welcome to the Email Sender API! To send emails, make a POST request to /send_message with a JSON body like: { \"message\": \"Your email content.\", \"emails\": [\"recipient1@example.com\", \"recipient2@example.com\"] }"
  end
end