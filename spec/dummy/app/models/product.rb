class Product < ActiveRecord::Base
  attr_accessible :code, :external_id, :name, :price

  so24 :product

  def self.import_all
    remote.all.each do |pdata|
      create({
        code: pdata[:product_no],
        external_id:pdata[:product_id],
        name:pdata[:name],
        price: pdata[:price]
      })
    end
  end
end
