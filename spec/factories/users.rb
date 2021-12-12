require "faker"

FactoryBot.define do
  factory :user do
    login { "user_123" }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :default_user do
      login { "default_user" }
      email { "default_user@example.com" }
      password { "DefaultUser.123" }
    end
  end
end
