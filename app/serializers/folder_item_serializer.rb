class FolderItemSerializer < ActiveModel::Serializer
  attributes :title, :description, :url

  belongs_to :folder
end
