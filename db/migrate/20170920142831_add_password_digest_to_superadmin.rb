class AddPasswordDigestToSuperadmin < ActiveRecord::Migration[5.1]
  def change
    add_column :superadmins, :password_digest, :string
    remove_column :superadmins, :password, :string
  end
end
