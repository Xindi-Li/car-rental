class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :email
      t.string :lpn
      t.datetime :expect_start_time
      t.datetime :checkout_time
      t.datetime :expect_return_time
      t.datetime :return_time
      t.string :status
      t.decimal :charge

      t.timestamps
    end
  end
end
