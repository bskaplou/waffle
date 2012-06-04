require 'yajl'

module Waffle
  module Encoders
    module Json
      module_function
      def encode message
        Yajl::Encoder.encode(message)
      end

      def decode message
        Yajl::Parser.parse(message)
      end
    end
  end
end
