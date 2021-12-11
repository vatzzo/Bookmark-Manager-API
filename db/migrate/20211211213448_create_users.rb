class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :login, null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
