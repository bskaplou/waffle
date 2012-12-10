module Waffle
  class Config
    class Node
      attr_accessor :settings

      class << self
        def option(name, options = {})
          defaults[name] = options[:default]

          class_eval <<-RUBY
            def #{name}
              settings[#{name.inspect}] || defaults[#{name.inspect}]
            end

            def #{name}=(value)
              settings[#{name.inspect}] = value
            end

            def #{name}?
              #{name}
            end
          RUBY
        end

        def defaults
          @defaults ||= {}
        end
      end
      
      option :url, :default => nil
      option :encoder, :default => 'json'
      option :transport, :default => nil
      option :connection_attempt_timeout, :default => 30
      option :options, :default => {'exchange' => 'events', 'queue' => ''}

      def initialize config = {}
        @settings = config ? defaults.merge(config) : {}
        yield self if block_given?
      end

      protected
      def defaults
        self.class.defaults
      end
    end

    class << self
      def load! options = nil
        options[:path] ? load_from_yaml!(options[:path]) : load_from_hash!(options)
        self
      end

      def configured?
        !!@configured
      end

      def reset_config!
        @queues = {}
        @configured = false
      end

      def default &block
        queue(:default, &block).tap do 
          @configured = true
        end
      end

      def queue name, &block
        queues[name] = Transports.create(Node.new(&block))
        nil
      end

      def queues
        @queues ||= {}
      end

      protected
      def load_from_yaml! filename
        filename = Rails.root.join(filename) if defined?(Rails)
        filename = File.expand_path(filename)

        if File.exists?(filename)
          settings_hash = YAML.load_file(filename)[environment]
          load_from_hash!(settings_hash) if settings_hash
        end
      end

      def load_from_hash! settings_hash
        queues_config = settings_hash.delete('queues') || {}
        queues_config['default'] = settings_hash
        queues_config.each do |queue, config|
          config = Node.new(Node.defaults.merge(config.symbolize_keys))
          queues[queue.to_sym] = Transports.create(config)
        end
        @configured = true
      end

      def method_missing meth, *args
        if configured?
          queues[:default].config.send(meth, *args)
        else
          super
        end
      end

      def environment
        defined?(Rails) && Rails.respond_to?(:env) ? Rails.env : (ENV['RACK_ENV'] || 'development')
      end
    end
  end
end