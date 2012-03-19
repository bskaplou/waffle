module Waffle
  class Configuration

    def initialize(custom_params = {})
      @configuration = {'strategy' => 'rabbitmq', 'url' => nil}.merge custom_params
    end

    def method_missing(m, *args, &block)
      if @configuration.has_key? m.to_s
        @configuration[m.to_s]
      else
        super
      end
    end

  end
end
