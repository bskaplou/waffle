module Waffle
  class Configuration

    def initialize(custom_params = {})
      @configuration['strategy'] = 'rabbitmq'
      @configuration['url']      = ''
      @configuration.merge custom_params
    end

  end
end
