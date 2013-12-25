module Savon::So24
  module Model
    class Base
      extend Operations


      #several methods for the connect - disconnect
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


      #the request methods, trying to make them common for all models
      def self.create data
        request "save_#{snake_name}", "#{snake_name}_item" => data
      end

      #this is a base method for most part of requests
      #probably will be overwritter for a number of models
      def self.where params = {}
        res = request(search_action_name, "#{snake_name}_search" =>params)
        res && res["#{snake_name}_item".to_sym] || []
      end

      def self.find id
        where id:id
      end

      def self.all
        where
      end

      def data
        self.class.find local.external_id
      end

      protected
      def self.search_action_name
        "get_#{snake_name.pluralize}"
      end

    end
  end
end