class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :lpn
      t.string :manufactuere
      t.string :model
      t.decimal :hrr
      t.string :style
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
