module EventPublisher
  class Event < ActiveRecord::Base
    # Accessible attributes
    attr_accessible :name

    # Relations
    has_many :event_trackings
  end
end
