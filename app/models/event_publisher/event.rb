module EventPublisher
  class Event < ActiveRecord::Base
    # Relations
    has_many :event_trackings
  end
end
