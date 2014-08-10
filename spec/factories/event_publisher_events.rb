# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_publisher_event, :class => 'EventPublisher::Event' do
    name "User logged in"
  end
end
