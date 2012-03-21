require 'yaml'

module Waffle
  class Configuration

    def initialize(custom_params = {})
      @configuration = {'transport' => 'rabbitmq', 'url' => nil, 'encoder' => 'json'}

      if defined? Rails
        @configuration.merge! YAML.load_file("#{Rails.root}/config/#{Rails.env}.waffle.yml")
      end

      @configuration.merge! custom_params
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
