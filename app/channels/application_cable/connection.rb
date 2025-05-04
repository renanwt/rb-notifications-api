module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user_id

    def connect
      self.user_id = cookies.signed&.dig(:user_id)&.to_s || reject_unauthorized_connection
    end
  end
end
