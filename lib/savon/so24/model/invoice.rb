module Savon::So24::Model
  class Invoice < Base

    def self.find id
      where order_id_from:id, order_id_to:id
    end

    protected
    def self.search_action_name
      "get_invoices_with_rows"
    end
  end
end