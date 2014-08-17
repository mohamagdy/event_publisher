# EventPublisher

## Installation

1. Either run `gem install event_publisher` or add the gem to the Gemfile `gem 'event_publisher'` then run the bundle command.
2. Install the gem's migrations using the command `rake event_publisher:install:migrations`

## Usage

### Models
The trackable (user) model should look like something like this

```rb
class Trackble
  trackable
end
```

Where `trackable` adds the following:
1. `has_many` relation between `users` and `event_publisher_events_trackings` table
2. An instance method called `track_event(event)` that can be called on the user object and track event.

### Controllers

#### Tracking events
To track events in controllers, you can use the following like in any action

```rb
track_event(current_user, "Listing articles")
```

#### Migrating events after logging in
After the user logged in, you can use this method `migrate_events_after_login(current_user)` which migrates
all the events for the user before logging in. It uses cookies to store the user's ID and type to be able to
track events.

If you're using devise gem, you can use the `migrate_events_after_login` as follows:

```rb
# In application_controller
def after_sign_in_path_for(resource)
  migrate_events_after_login(resource)
  super
end
```
