require_relative '../httperrors'

module Lumpi
  module HttpServer
    class Delegator
      def initialize
      end

      def delegate(request)
        delegator_method = "delegate_#{request.method.downcase}".to_sym
        raise Lumpi::HttpErrors::MethodNotSupportedError.new unless self.methods.include?(delegator_method)

        method(delegator_method).call(request)
      end

      def get(path, &block)
        raise StandardError.new("block expected") if block.nil?

        unless self.class.methods.include?(:delegate_get)
          self.class.define_method(:delegate_get) do |request|
            raise Lumpi::HttpErrors::ResourceNotFoundError.new if request.path.downcase != path.downcase
            block.call(request)
          end  
        end
      end

    end
  end
end