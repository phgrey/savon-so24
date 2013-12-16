module Savon::So24
  class Auth
    extend Operations

    class << self
      def connect
        locals = {credential:Savon::So24.config.select{|k,v| [:username, :password, :type].include? k}}
        connected = request :login, locals  do |resp|
          @cookie =  resp.http.headers['set-cookie']
        end
        connected && @cookie
      end

      def cookie
        @cookie || connect
      end

      def connected?
        !@cookie.nil? && check_connected
      end

      def check_connected
        global(:headers, { 'cookie' => @cookie})
        request :get_identity
        true
      rescue
        false
      end
    end


  end
end