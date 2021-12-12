class CreateFolderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :folder_items, id: :uuid do |t|
      t.string :title, null: false
      t.text :description
      t.string :url, null: false
      t.references :folder, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
