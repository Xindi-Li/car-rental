class AddImgAttachToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :img_attach, :string
  end
end
