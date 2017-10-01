class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :email
      t.string :message

      t.timestamps
    end
  end
end
