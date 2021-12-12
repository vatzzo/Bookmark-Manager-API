module AuthServices
  module Errors
    class InvalidToken < BaseError
      def initialize
        super(:invalid_token, 401, "Token is invalid")
      end
    end
  end
end
