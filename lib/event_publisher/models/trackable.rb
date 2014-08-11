module EventPublisher
  module Trackable
    def trackable
      # Relations
      has_many :event_trackings, class_name: "EventPublisher::EventTracking", as: :trackable

      include InstanceMethods
    end
  end

  module InstanceMethods
    def track_event(event)
      event = Event.where(name: event).first_or_create if event.is_a?(String)
      self.event_trackings.create(event_id: event.id)
    end
  end
end

ActiveRecord::Base.extend EventPublisher::Trackable