module EventPublisher
  module Tracker
    def track_event(user, event)
      user.track_event(event)
    end
  end
end

ActionController::Base.include EventPublisher::Tracker