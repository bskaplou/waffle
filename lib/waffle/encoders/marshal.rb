module Waffle
  module Encoders
    module Marshal
      module_function
      def encode message
        ::Marshal.dump(message)
      end

      def decode message
        ::Marshal.restore(message)
      end
    end
  end
end
