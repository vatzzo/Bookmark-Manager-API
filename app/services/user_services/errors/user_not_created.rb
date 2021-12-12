module UserServices
  module Errors
    class UserNotCreated < BaseError
      def initialize(message)
        super(:user_not_created, 422, message)
      end
    end
  end
end