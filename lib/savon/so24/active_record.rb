module Savon::So24
  module ActiveRecord
    def so24 options
      options = {name:options} unless options.is_a? Hash
      e_class = options[:class] || ['Savon','So24', 'Model', options[:name].to_s.camelcase].join('::').constantize
      throw new Exception "Class #{self.name} already has included another Savon::So24 model" if self.included_modules.include? LocalMethods
      class_attribute :so24_class
      self.so24_class = e_class
      include LocalMethods
      throw new Exception "Class #{e_class} has been already included by another ActiveRecord model" if e_class.included_modules.include? RemoteMethods
      e_class.send :include, RemoteMethods
    end

    module LocalMethods
      extend ActiveSupport::Concern

      def remote
        @so24_instance ||= so24_class.new self
      end

      def so24_config
        self.class.so24_config
      end

      module ClassMethods
        def remote
          so24_class
        end

        def so24_config
          remote.config
        end
      end
    end

    module RemoteMethods
      def initialize local
        @local = local
        super()
      end

      def method_missing *args
        return @local.public_send(*args) if @local.respond_to? args[0]
        super
      end

      def respond_to? name
        @local.respond_to?(name) || super
      end
    end
  end
end