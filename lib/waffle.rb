$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'rubygems'
require 'bundler'
environment = defined?(Rails) && Rails.respond_to?(:env) ? Rails.env : (ENV['RACK_ENV'] || 'development')
Bundler.require :default, environment.to_sym
require 'waffle/version'
require 'time'

module Waffle
  extend self
  module Transports
    autoload :Base, 'waffle/transports/base'
    autoload :Rabbitmq, 'waffle/transports/rabbitmq' if defined?(Bunny)
    autoload :Redis, 'waffle/transports/redis' if defined?(::Redis)
  end

  autoload :Config, 'waffle/config'
  autoload :Event, 'waffle/event'

  module Encoders
    autoload :Json, 'waffle/encoders/json' if defined?(Yajl)
    autoload :Marshal, 'waffle/encoders/marshal'
  end

  def reset_config!
    @configured = false
  end

  def configure options=nil
    @configured ||= begin
      options = {:path => 'config/waffle.yml'} unless options
      Config.load!(options)
      true
    end
    block_given? ? yield(Config) : Config
  end

  def publish flow = 'events', message = ''
    transport.publish(flow, message)
  rescue Bunny::ConnectionError, Errno::ECONNRESET => e
    transport.reconnect && retry if transport.ready_to_connect?
  end

  def subscribe flow = '', &block
    transport.subscribe(flow, &block)
  rescue Bunny::ConnectionError, Errno::ECONNRESET => e
    until transport.reconnect do
      sleep(config.connection_attempt_timeout)
    end
    retry
  end

  def transport
    @transport ||= "Waffle::Transports::#{Waffle.config.transport.camelize}".constantize.new
  end

  def encoder
    @encoder ||= "Waffle::Encoders::#{Waffle.config.encoder.camelize}".constantize
  end

  alias :config :configure
end

unless defined?(ActiveSupport::Inflector)
  class String
    def constantize
      names = self.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end

    def camelize
      string = sub(/^[a-z\d]*/){$&.capitalize}
      string.gsub(/(?:_|(\/))([a-z\d]*)/){ "#{$1}#{$2.capitalize}" }.gsub('/', '::')
    end
  end
end

unless defined?(ActiveSupport)
  class Hash
    def symbolize_keys!
      keys.each do |key|
        self[(key.to_sym rescue key) || key] = delete(key)
      end
      self
    end

    def symbolize_keys
      dup.symbolize_keys!
    end
  end
end
