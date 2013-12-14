module Savon::So24::Model
  class Product < Base

    def self.all
      request(:get_product, product_search:{})[:product_item]
    end

    def self.find id
      request(:get_product, product_search:{product_id:id})[:product_item]
    end

  end
end