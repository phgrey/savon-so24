module Savon::So24::Model
  class Person < Base

    def self.by_company company_id
      where customer_id:company_id
    end

  protected
    def self.snake_name_plural
      'persons'
    end

  end
end