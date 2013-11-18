# Make components auto-loadable
require 'active_support/dependencies'
ActiveSupport::Dependencies.autoload_paths << File.dirname(__FILE__)

require 'savon/so24'

module Savon
  module So24

  end
end


require 'savon/so24/wasabi_patch'