class Folder < ApplicationRecord
  belongs_to :user
  has_many :folder_items

  validates :name, presence: true, length: { in: 3..20 },
                   uniqueness: { case_sensitive: false }
end
