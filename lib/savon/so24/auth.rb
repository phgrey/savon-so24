module Savon::So24
  class Auth
    extend Operations

    class << self
      attr_accessor :cookie

      def credentials
        # TODO: make correct config saving and getting
        #Settings.crm_config
        {
            username: '265026271343230_9128',
            password: '763047fac329421bedcc60b7a1786e4a',
            type: 'Client',
            #type: '24SO',
        }
      end

      def connect
        #locals = {credential:config.select{|k,v| [:sername, :password].include? k}.merge({type:'Client'})}
        locals = {credential:credentials}
        connected = request :login, locals  do |resp|
          self.cookie =  resp.http.headers['set-cookie']
        end
        connected && self.cookie
      end

      def connected?
        !cookie.nil? && check_connected
      end

      def check_connected
        global(:headers, { 'cookie' => cookie})
        request :get_identity
        true
      rescue
        false
      end
    end


  end
end