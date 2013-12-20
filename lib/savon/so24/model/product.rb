module Savon::So24::Model
  class Product < Base

    def self.find id
      where product_id:id
    end

  protected
    def self.snake_name_plural
      snake_name
    end
  end
end