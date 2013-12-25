module Savon::So24::Model
  class Product < Base

    def self.find id
      where product_id:id
    end

  protected
    def self.search_action_name
      'get_product'
    end
  end
end