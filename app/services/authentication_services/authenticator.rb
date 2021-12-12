module AuthenticationServices
  class Authenticator < ApplicationService
    def initialize(login:, password:)
      @login = login
      @password = password
    end

    attr_reader :login, :password

    def call
      raise AuthenticationServices::Errors::InvalidPassword unless user

      JWT.encode payload, secret
    end

    private

    def payload
      {
        login: user.login,
        email: user.email,
        exp: 1.hour.from_now.to_i
      }
    end

    def user
      @user ||= User.find_by!(login: login).authenticate(password)
    end

    def secret
      Rails.application.secrets.secret_key_base
    end
  end
end
