require "faker"

user = User.find_or_initialize_by(email: "admin@example.com").tap do |obj|
  obj.update!(
    password: "AdminExample.123",
    login: "admin_123"
  )
end

time_now = Time.zone.now

if user.folders.count < 10
  folder_attrs = []

  10.times do
     folder_attrs << { name: SecureRandom.alphanumeric(15), created_at: time_now, updated_at: time_now, user_id: user.id }
  end

  user.folders.insert_all(
    folder_attrs,
    unique_by: :name
  )
end

if user.folder_items.size < 50
  folder_items_attrs = []
  folder_ids = user.folders.pluck(:id)

  folder_ids.each do |folder_id|
    5.times do
      folder_items_attrs << { 
        title: SecureRandom.alphanumeric(10),
        description: Faker::Book.title,
        url: Faker::Internet.url,
        folder_id: folder_id,
        created_at: time_now,
        updated_at: time_now
      }
    end
  end

  FolderItem.insert_all(folder_items_attrs)
end
