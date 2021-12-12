require "faker"

FactoryBot.define do
  factory :folder do
    name { SecureRandom.alphanumeric(10) }

    trait :with_folder_items do
      transient do
        amount { 3 }
      end

      after :create do |folder, options|
        options.amount.times { create(:folder_item, folder: folder) }
      end
    end

    association :user
  end
end
