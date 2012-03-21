module Waffle
  module Encoders
    class Marshal

      class << self

        def encode(message = nil)
          ::Marshal.dump message
        end

        def decode(message = '')
          ::Marshal.restore message
        end

      end

    end
  end
end
