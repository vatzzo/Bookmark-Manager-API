module AuthServices
  module Errors
    class MissingToken < BaseError
      def initialize
        super(:missing_token, 401, "Token is missing")
      end
    end
  end
end
