class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.integer :external_id

      t.timestamps
    end
  end
end
