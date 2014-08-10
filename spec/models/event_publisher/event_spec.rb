require 'rails_helper'

module EventPublisher
  RSpec.describe Event, type: :model do
    context "Listing tracked events of a specific event" do
      it "should list all the tracked event of a specific event" do
        login_event = create(:event_publisher_event)
        tracked_events = create_list(:event_publisher_event_tracking, 3, event: login_event)

        expect(login_event.event_tracking_ids).to eq(tracked_events.map(&:id))
      end
    end
  end
end
