module EventPublisher
  class EventTracking < ActiveRecord::Base
    # Relations
    belongs_to :event
    belongs_to :trackable, polymorphic: true
  end
end
