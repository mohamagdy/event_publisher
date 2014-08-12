module EventPublisher
  module Trackable
    def track_event(user, event)
      user ||= current_anonymous_user

      # Save the user ID in a signed cookie so no one can tweak it
      cookies.signed[:event_publisher_user_id] = user.id

      user.track_event(event) # Creating the event
    end

    # A method used to create an anonymous user to attach
    # the events to.
    def current_anonymous_user
      EventPublisher::AnonymousUser.find_by_id(cookies.signed[:event_publisher_user_id]) ||
      EventPublisher::AnonymousUser.create
    end
  end
end

ActionController::Base.include EventPublisher::Trackable