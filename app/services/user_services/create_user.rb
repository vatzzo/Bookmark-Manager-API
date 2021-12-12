module UserServices
  class CreateUser < ApplicationService
    def initialize(email:, login:, password:)
      @email = email
      @login = login
      @password = password
    end

    attr_reader :email, :login, :password

    def call
      User.create!(email: email, login: login, password: password)
    end
  end
end
