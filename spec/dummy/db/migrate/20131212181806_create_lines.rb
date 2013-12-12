class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :order
      t.references :product
      t.integer :count
      t.string :name
      t.float :price

      t.timestamps
    end
    add_index :lines, :order_id
    add_index :lines, :product_id
  end
end
