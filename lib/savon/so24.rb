require 'savon/so24/version'
require 'active_record/base'
require 'savon/soap_fault'

ActiveRecord::Base.send(:extend, Savon::So24::ActiveRecord)

module Savon
  module So24
    extend Helper

    def self.init
      SOAPFault.send :include, So24::Exception
    end

  end
end