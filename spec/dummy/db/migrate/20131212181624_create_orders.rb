class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.string :number
      t.references :user
      t.references :delivery_location
      t.references :invoice_location
      t.text :comment
      t.integer :external_id

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :delivery_location_id
    add_index :orders, :invoice_location_id
  end

  def down
    drop_table :orders
  end
end
