require "faker"

FactoryBot.define do
  factory :folder do
    name { SecureRandom.alphanumeric(10) }

    association :user
  end
end
