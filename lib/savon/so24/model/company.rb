module Savon::So24::Model
  class Company < Base

  protected
    def self.search_action_name
      'get_companies_detailed'
    end

  end
end