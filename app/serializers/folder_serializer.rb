class FolderSerializer < ActiveModel::Serializer
  attributes :name, :created_at, :updated_at

  has_many :folder_items, key: :items

  def folder_items
    return [] if object.folder_items.empty?

    object.folder_items
  end
end
