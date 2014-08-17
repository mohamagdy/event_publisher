module EventPublisher
  class Event < ActiveRecord::Base
    attr_protected if defined?(attr_protected)

    # Relations
    has_many :event_trackings
  end
end
