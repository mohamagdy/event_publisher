module EventPublisher
  class EventTracking < ActiveRecord::Base
    # Accessible attributes
    attr_accessible :event_id, :ip, :operation_system, :trackable_id, :trackable_type

    # Relations
    belongs_to :event
  end
end
