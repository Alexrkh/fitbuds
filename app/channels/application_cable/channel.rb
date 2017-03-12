module ApplicationCable
  class Channel < ActionCable::Channel::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end 

    private

    def find_verified_user
      if current_user = User.find_by(id: cookie.signed(:user_id))
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
