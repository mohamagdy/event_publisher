module EventPublisher
  class AnonymousUser < ActiveRecord::Base
    # Relations
    has_many :event_trackings, as: :trackable

    # Track events
    trackable
  end
end
