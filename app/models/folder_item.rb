class FolderItem < ApplicationRecord
  belongs_to :folder

  validates :title, presence: true, length: { in: 3..20 }
  validates :description, length: { in: 5..60 }
  validates :url, presence: true
end
