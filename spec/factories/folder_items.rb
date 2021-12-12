require "faker"

FactoryBot.define do
  factory :folder_item do
      title { SecureRandom.alphanumeric(10) }
      description { Faker::Book.title }
      url { Faker::Internet.url }

    association :folder
  end
end
