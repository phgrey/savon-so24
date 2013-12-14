class Savon::So24::ClientManager
  class << self
    def make_client model, globals = {}
      @clients ||={}
      wsdl = globals[:wsdl] || wsdl_for(model) || raise(Savon::InitializationError, 'please specify wsdl')
      @clients[wsdl] = Savon::Client.new globals.merge wsdl:wsdl
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