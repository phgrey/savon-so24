class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.references :company
      t.integer :external_id

      t.timestamps
    end
    add_index :users, :company_id
  end
end
