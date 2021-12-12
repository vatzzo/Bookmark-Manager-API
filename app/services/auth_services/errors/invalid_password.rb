module AuthServices
  module Errors
    class InvalidPassword < BaseError
      def initialize
        super(:invalid_password, 401, "Wrong password has been passed")
      end
    end
  end
end
