require 'singleton'
require 'yaml'

module Waffle
  class Config
    include Singleton

    attr_reader :config_hash

    def load_config!
      @config_hash = default_config
      filename = "config/waffle.yml"
      filename = ENV['WAFFLE_CONFIG'] unless ENV['WAFFLE_CONFIG'].nil?

      if defined? Rails
        fielname = "#{Rails.root}/config/waffle.yml"
      end

      if File.exists?(filename)
        loaded_config = YAML.load_file filename

        if defined?(Rails) && loaded_config[Rails.env]
          @config_hash.merge! loaded_config[Rails.env]
        else
          @config_hash.merge! loaded_config
        end
      end
    end
    
    def config_hash
      @config_hash ||= {}
    end
    
    def default_config
      {'transport' => 'rabbitmq', 'url' => nil, 'encoder' => 'json'}
    end

    class << self
      def load_config!
        self.instance.load_config!
      end
      
      def setup! config
        self.instance.config_hash.replace(self.instance.default_config.merge(config))
        nil
      end

      def method_missing(m, *args, &block)
        self.load_config! if self.instance.config_hash.empty?
        if self.instance.config_hash.has_key?(m.to_s)
          self.instance.config_hash[m.to_s]
        else
          super
        end
      end

    end

  end
end
