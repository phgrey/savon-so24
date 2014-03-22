require 'savon/soap_fault'

# As far i do not want to inherit from Savon::Exception own
# i'll extend it with several methods to check

module Savon::So24::Exception
  #def is_integrity?
  #  check_with_regexp /Economic\.Api\.Exceptions\.IntegrityException/
  #end

  def is_auth_not_logged?
    check_with_regexp(/System\.Exception: The request to .* is not authenticated/)
  end

  def short
    message
  end

  private

  def check_with_regexp reg
    !(reg=~message).nil?
  end
end