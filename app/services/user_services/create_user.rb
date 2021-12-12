module UserServices
  class CreateUser < ApplicationService
    def initialize(email:, login:, password:)
      @email = email
      @login = login
      @password = password
    end

    attr_reader :email, :login, :password

    def call
      user = User.new(email: email, login: login, password: password)
      raise Errors::UserNotCreated, user.errors.full_messages unless user.valid?

      user.save
    end
  end
end
