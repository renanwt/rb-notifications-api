require "rails_helper"

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    it "returns a welcome message" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(
        "Welcome to the Email Sender API! To send emails, make a POST request to /send_message with a JSON body like: { \"message\": \"Your email content.\", \"emails\": [\"recipient1@example.com\", \"recipient2@example.com\"] }"
      )
    end
  end
end
