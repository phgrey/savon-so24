module Savon::So24::Model
  class Company < Base

    def self.find id
      request(:get_companies, company_search:{id:id})[:company_item]
    end
  end
end