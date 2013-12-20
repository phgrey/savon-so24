class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country
      t.string :city
      t.string :pcode
      t.string :address
      t.string :address2
      t.string :name
      t.string :phone
      t.string :type
      t.references :user

      t.timestamps
    end
    add_index :locations, :user_id
  end
end
