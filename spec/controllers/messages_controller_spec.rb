require "rails_helper"

RSpec.describe MessagesController, type: :controller do
  describe "POST #send_message" do
    it "broadcasts the message and returns success" do
      expect(ActionCable.server).to receive(:broadcast).with("messages_channel", message: "What's up duuuude?")
      post :send_message, params: { message: "What's up duuuude?" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ "status" => "Message sent" })
    end
  end
end
