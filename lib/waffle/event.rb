module Waffle
  class Event

    class << self

      def occured(event_name = 'event', event_data = {})
        @@config   ||= Waffle::Configuration.new
        @@producer ||= eval("Waffle::Strategies::#{@@config.strategy.capitalize}::Producer").new @@config
      end

    end

  end
end
