module EventPublisher
  module Trackable
    # This method logs the user's event.
    # Usage:
    #   track_event(current_user, "Logged in")
    def track_event(user, event)
      user ||= current_event_publisher_user || current_anonymous_user

      set_cookies_for(user)

      user.track_event(event) # Creating the event
    end

    # This method is called after the user logged in to migrate
    # the events stored before logging in (as anonymous user).
    # Usage:
    #   def after_login_path(resource)
    #     migrate_events_after_login(resource)
    #   end
    def migrate_events_after_login(user)
      previously_logged_in = current_event_publisher_user

      # Moving the events of the previosuly logged in user to the current user
      previously_logged_in.event_trackings.update_all(
        trackable_type: user.class.name,
        trackable_id: user.id
      )

      # Setting/overriding the cookies for the current user
      set_cookies_for(user)
    end

    private
    # A method used to create an anonymous user to attach
    # the events to.
    def current_anonymous_user
      EventPublisher::AnonymousUser.find_by_id(cookies.signed[:event_publisher_user_id]) ||
      EventPublisher::AnonymousUser.create
    end

    # Sets the event_publisher cookies. The cookies are:
    #   event_publisher_user_id: stores the user's id
    #   event_publisher_user_type: stores the user type. For exaple AnonymousUser or User
    def set_cookies_for(user)
      # Save the user ID in a signed cookie so no one can tweak it
      cookies.signed[:event_publisher_user_id] = user.id
      cookies.signed[:event_publisher_user_type] = user.class.name
    end

    # Returns the current_user for event_publisher.
    # It's different from current_user where it finds
    # the user using the cookies event_publisher_user_type
    # and event_publisher_user_id
    def current_event_publisher_user
      klass = cookies.signed[:event_publisher_user_type]
      user_id = cookies.signed[:event_publisher_user_id]

      klass.constantize.find_by_id(user_id) if klass.present?
    end
  end
end

ActionController::Base.include EventPublisher::Trackable