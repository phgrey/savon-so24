module Savon::So24
  module Model
    class Base
      extend Operations

      def self.reconnect
        clean_headers
        global(:headers, { 'cookie' => Auth.connect})
      end

      def self.clean_headers
        client.globals[:headers].present? &&  client.globals[:headers].delete('cookie')
      end

      def self.request(operation, *args)
        #we will re-set this header every time just to be sure it is set
        global(:headers, { 'cookie' => Auth.cookie})
        begin
          super
        rescue Savon::SOAPFault => ex
          if ex.is_auth_not_logged?
            reconnect && super
          else
            raise ex
          end
        end
      end





    end
  end
end