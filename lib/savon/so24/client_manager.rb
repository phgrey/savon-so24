class Savon::So24::ClientManager
  class << self
    def make_client model, globals = {}
      @clients ||={}
      globals[:wsdl]||= wsdl_for(model) || raise(Savon::InitializationError, 'please specify wsdl')

      @clients[globals[:wsdl]]||= Savon::Client.new make_globals globals
    end


    def make_globals globals
      #we will have to convert theese tags ourselves
      globals[:convert_request_keys_to] = :none
      globals[:log] = Rails.env == 'development'
      globals[:wsdl] = save_wsdl globals[:wsdl] if globals[:wsdl]
      globals
    end

    def save_wsdl url
      path = Rails.root.join('tmp/wsdls/').join url.split('/').last.split('?').first
      `wget -O #{path} -q --no-check-certificate #{url}` unless path.exist?
      path
    rescue
      url
    end

    def client model

      @clients && @clients[wsdl_for model]
    end

    def wsdl_for model

      hash = Hash[%w(product invoice).map{|v|
        cv = v.camelcase
        [v, "https://webservices.24sevenoffice.com/Economy/#{cv}/#{cv}Service.asmx?WSDL"]
      }].merge({
        'auth' => 'https://webservices.24sevenoffice.com/authenticate/authenticate.asmx?wsdl',
        'company' => 'https://webservices.24sevenoffice.com/CRM/Company/CompanyService.asmx?WSDL',
        'person' => 'https://webservices.24sevenoffice.com/CRM/Contact/PersonService.asmx?WSDL',
        #'_blank' => '',
      })
      hash[model.to_s]
    end
  end
end