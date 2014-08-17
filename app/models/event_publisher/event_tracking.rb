module EventPublisher
  class EventTracking < ActiveRecord::Base
    attr_protected if defined?(attr_protected)

    # Relations
    belongs_to :event
    belongs_to :trackable, polymorphic: true
  end
end
