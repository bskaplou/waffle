require 'yajl'

module Waffle
  class Utils

    class << self

      def encode(message = nil)
        Yajl::Encoder.encode message
      end

      def decode(message = '')
        Yajl::Parser.parse message
      end

    end

  end
end
