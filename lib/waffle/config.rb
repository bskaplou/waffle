require 'yaml'

module Waffle
  module Config
    extend self
    attr_accessor :settings, :defaults

    @settings = {}
    @defaults = {}

    def option(name, options = {})
      defaults[name] = settings[name] = options[:default]

      class_eval <<-RUBY
        def #{name}
          settings[#{name.inspect}]
        end

        def #{name}=(value)
          settings[#{name.inspect}] = value
        end

        def #{name}?
          #{name}
        end
      RUBY
    end

    option :url, :default => nil
    option :encoder, :default => 'json'
    option :transport, :default => nil
    option :connection_attempt_timeout, :default => 30

    def load! options=nil
      options[:path] ? load_from_yaml!(options[:path]) : load_from_hash!(options)
      self
    end

    def load_from_yaml! filename
      filename = Rails.root.join(filename) if defined?(Rails)
      filename = File.expand_path(filename)

      if File.exists?(filename)
        settings_hash = YAML.load_file(filename)[environment]
        @settings = defaults.merge(settings_hash.symbolize_keys) if settings_hash
      end
    end

    def load_from_hash! options
      @settings = defaults.merge(options)
    end
    
    def environment
      defined?(Rails) && Rails.respond_to?(:env) ? Rails.env : (ENV['RACK_ENV'] || 'development')
    end
  end
end
