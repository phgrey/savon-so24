class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.float :price
      t.integer :external_id

      t.timestamps
    end
  end
end
