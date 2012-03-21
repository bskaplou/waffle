require 'singleton'
require 'yaml'

module Waffle
  class Config
    include Singleton

    attr_reader :config_hash

    def initialize
      @config_hash = {'transport' => 'rabbitmq', 'url' => nil, 'encoder' => 'json'}

      if defined? Rails
        @config_hash.merge! YAML.load_file("#{Rails.root}/config/#{Rails.env}.waffle.yml")
      end
    end

    class << self

      def method_missing(m, *args, &block)
        if self.instance.config_hash.has_key?(m.to_s)
          self.instance.config_hash[m.to_s]
        else
          super
        end
      end

    end

  end
end
