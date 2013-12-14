module Savon::So24::Model
  class Person < Base

    def self.all
      request(:get_persons, person_search:{})[:person_item]
    end

    def self.find id
      request(:get_persons, person_search:{id:id})[:person_item]
    end

  end
end