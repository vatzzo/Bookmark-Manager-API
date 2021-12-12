module AuthServices
  class Authorizer < ApplicationService
    def initialize(headers: {})
      @headers = headers
    end

    def call
      raise Errors::InvalidToken unless user
      user
    end

    private

    attr_reader :headers

    def user
      @user ||= User.find_by(login: decoded_auth_token[:login]) if decoded_auth_token.present?
    end

    def decoded_auth_token
      @decoded_auth_token ||= begin
        body = JWT.decode(http_auth_header, secret)[0]
        HashWithIndifferentAccess.new(body)
      end
    end

    def http_auth_header
      raise Errors::MissingToken if headers["Authorization"].blank?
      return headers["Authorization"].split(" ").last 
    end

    def secret
      Rails.application.secrets.secret_key_base
    end
  end
end
