require "faker"

FactoryBot.define do
  factory :user do
    login { "user_123" }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
