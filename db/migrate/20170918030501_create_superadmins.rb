class CreateSuperadmins < ActiveRecord::Migration[5.1]
  def change
    create_table :superadmins do |t|
      t.string :username
      t.string :password
    end
  end
end
