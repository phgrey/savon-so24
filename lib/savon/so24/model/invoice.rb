module Savon::So24::Model
  class Invoice < Base

    def self.all
      request(:get_invoices, invoice_search:{})[:invoice_item]
    end

    def self.find id
      list = request :get_invoices, invoice_search:{order_id_from:id, order_id_to:id}
      list# && list[:invoice_item]
    end
  end
end