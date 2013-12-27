module Savon::So24::Model
  class Person < Base

    def self.by_company company_id
      where customer_id:company_id
    end

    def self.relate data
      request(:make_relation, relation:data)
    end

  protected
    def self.search_action_name
      'get_persons_detailed'
    end

  end
end