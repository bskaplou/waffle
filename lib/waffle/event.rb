require 'singleton'

module Waffle
  class Event
    include Singleton

    def configuration
      @config ||= Waffle::Configuration.new
    end

    def strategy
      @strategy ||= eval("Waffle::Strategies::#{@@config.strategy.capitalize}").new config
    end

    def occured(event_name = 'event', event_data = {})
      puts 'Message published!'
    end

  end
end
