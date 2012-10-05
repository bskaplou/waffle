module Waffle
  class Event
    class << self
      def occured(event_data, options = {})
        options = {
          :event_name => 'event',
          :queue => :default
        }.merge(options)

        unless event_data.is_a?(Hash)
          event_data = {'body' => event_data.to_s}
        end

        event_data.merge!({'occured_at' => Time.now})

        Waffle.queue(options[:queue]).publish(options[:event_name], event_data)
      end
      alias :occurred :occured
    end
  end
end
