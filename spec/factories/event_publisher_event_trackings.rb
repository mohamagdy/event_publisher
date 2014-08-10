# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_publisher_event_tracking, :class => 'EventPublisher::EventTracking' do
    trackable_id 1
    trackable_type "User"
    event_id 1
    ip "127.0.0.1"
    operation_system "Mac OSX"
  end
end
