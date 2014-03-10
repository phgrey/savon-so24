module Savon::So24
  module Model
    class Base
      extend Operations



      #several methods for the connect - disconnect
      def self.connect
        clean_headers
        global(:headers, { 'cookie' => Auth.connect})
      end

      def self.connected?
        Auth.connected?
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
            connect && super
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
        ret = res && res["#{snake_name}_item".to_sym] || []
        ret.is_a?(Array) ? ret : [ret]
      end

      def self.find id
        where(id:id).first
      end

      def self.all
        where
      end

      def self.delete id
        raise('Not implemented yet')
      end

      def delete
        self.class.delete external_id
      end

      def data
        self.class.find local.external_id
      end

      def self.export_all
        local.all.map{|p|
          begin
            create p.for_economic
          rescue Savon::SOAPFault => ex
            raise ex unless ex.is_integrity?
            false
          end
        }
      end

      protected
      def self.search_action_name
        "get_#{snake_name.pluralize}"
      end

      def self.extract_values hash
        hash && hash.values.flatten.map{|v|v[:value]}.select{|v|!v.nil?} || []
      end

    end
  end
end