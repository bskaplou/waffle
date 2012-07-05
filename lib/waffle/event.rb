module Waffle
  class Event
    class << self
      def occured(event_name = 'event', event_data = nil)
        unless event_data.is_a?(Hash)
          event_data = {'body' => event_data.to_s}
        end

        event_data.merge!({'occured_at' => Time.now})

        Waffle.publish(event_name, event_data)
      end
      alias :occurred :occured
    end
  end
end
