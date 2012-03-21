require 'yajl'

module Waffle
  module Encoders
    class Json

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
end
