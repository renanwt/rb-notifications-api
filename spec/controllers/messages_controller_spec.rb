require "rails_helper"

RSpec.describe MessagesController, type: :controller do
  describe "POST #send_message" do
    context "when valid parameters are provided" do
      it "queues jobs for each email and returns success" do
        message = "Hello, this is a test message!"
        emails = ["test1@example.com", "test2@example.com"]

        expect(SendEmailJob).to receive(:perform_async).with(message, "test1@example.com")
        expect(SendEmailJob).to receive(:perform_async).with(message, "test2@example.com")

        post :send_message, params: { message: message, emails: emails }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ "message" => "Jobs enfileirados para o envio de email" })
      end
    end

    context "when parameters are invalid" do
      it "returns an error if message is missing" do
        post :send_message, params: { emails: ["test@example.com"] }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ "error" => "'mensagem' e 'emails' são obrigatórios. E 'emails' deve ser um array" })
      end

      it "returns an error if emails are missing" do
        post :send_message, params: { message: "Hello, this is a test message!" }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ "error" => "'mensagem' e 'emails' são obrigatórios. E 'emails' deve ser um array" })
      end

      it "returns an error if emails is not an array" do
        post :send_message, params: { message: "Hello, this is a test message!", emails: "not_an_array" }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ "error" => "'mensagem' e 'emails' são obrigatórios. E 'emails' deve ser um array" })
      end

      it "returns an error if emails array is empty" do
        post :send_message, params: { message: "Hello, this is a test message!", emails: [] }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ "error" => "'mensagem' e 'emails' são obrigatórios. E 'emails' deve ser um array" })
      end
    end
  end
end
