require "rails_helper"

module ApplicationCable
  RSpec.describe Connection, type: :channel do
    let(:cookies) { instance_double(ActionDispatch::Cookies::CookieJar) }

    before do
      allow_any_instance_of(described_class).to receive(:cookies).and_return(cookies)
    end

    it "connects with cookies" do
      allow(cookies).to receive(:signed).and_return({ user_id: "42" })
      connect
      expect(connection.user_id).to eq("42")
    end

    it "rejects connection without cookies" do
      allow(cookies).to receive(:signed).and_return(nil)
      expect { connect }.to raise_error(ActionCable::Connection::Authorization::UnauthorizedError)
    end
  end
end
