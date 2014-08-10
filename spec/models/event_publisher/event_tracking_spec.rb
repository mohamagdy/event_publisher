require 'rails_helper'

module EventPublisher
  RSpec.describe EventTracking, type: :model do
    context "saving an event in the database" do
      it "should save the loggin event for a user" do
        login_event = create(:event_publisher_event)
        tracked_event = create(:event_publisher_event_tracking, event: login_event)

        expect(tracked_event.event.id).to eq(login_event.id)
      end
    end
  end
end
