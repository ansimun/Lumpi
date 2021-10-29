require_relative '../httperrors'

module Lumpi
  module HttpServer
    class Request
      ALLOWED_METHODS_PATTERN=/^(HEAD|GET|POST|PUT|DELETE|CONNECT|OPTIONS|TRACE|PATCH)$/
      ALLOWED_PATH_PATTERN=/^[a-zA-Z0-9\/\.]{1,}$/
      ALLOWED_VERSION_PATTERN=/^HTTP\/[0-9\.]+$/

      attr_reader :method, :path, :parameters, :request_text

      def initialize(httptext)
        @request_text = httptext
        @method, @path, @parameters = parse_headline
        @headers = nil
        @body = nil
      end

      def headers
        @headers ||= parse_headers
      end

      def body
        @body ||= parse_body
      end

      private

      def parse_headers
        headers={}
        @request_text.partition("\n\n")
          .first
          .scan(/^([a-zA-Z-]{3,}): (.+)$/) do |match|
            headers[match.first] = match.last
          end
        
        return headers
      end

      def parse_body
        content_length = get_content_length
        return "" if content_length.nil?

        return @request_text[-content_length..]
      end

      def get_content_length
        header_match = @request_text.scan(/Content-Length: ([0-9]+)$/)
        return nil if header_match.empty?

        header_match.first.first.to_i
      end

      def parse_headline
        headline = get_headline
        
        method, *remaining_components = headline.split
        raise Lumpi::HttpErrors::BadRequestError.new unless method.match?(ALLOWED_METHODS_PATTERN)
        raise Lumpi::HttpErrors::BadRequestError.new unless remaining_components.last.match?(ALLOWED_VERSION_PATTERN)

        path, params = remaining_components.first.split('?')
        raise Lumpi::HttpErrors::BadRequestError.new unless path.match?(ALLOWED_PATH_PATTERN)

        return method, path.downcase, parse_parameters(params)
      end

      def get_headline
        newline_index =  @request_text.index("\n")
        headline = @request_text[0..newline_index-1] unless newline_index.nil?
        headline = @request_text if newline_index.nil?

        return headline
      end

      def parse_parameters(parameter_text)
        return {} if parameter_text.nil?

        parameters={}
        parameter_text.scan(/([a-zA-Z_]+)=([^&]+)/) { |match| parameters[match.first] = match.last }

        return parameters
      end
    end
  end
end