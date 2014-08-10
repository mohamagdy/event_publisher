require 'rails_helper'

module EventPublisher
  RSpec.describe AnonymousUser, :type => :model do
    context "track events of anonymous user" do
      it "should track the events of an anonymous user" do
        anonymous_user = create(:event_publisher_anonymous_user)

        login_event = create(:event_publisher_event, name: "Login")
        logout_event = create(:event_publisher_event, name: "Logout")

        login_event_tracking = create(
          :event_publisher_event_tracking,
          event: logout_event,
          trackable: anonymous_user
        )

        logout_event_tracking = create(
          :event_publisher_event_tracking,
          event: logout_event,
          trackable: anonymous_user
        )

        expect(anonymous_user.event_trackings.pluck(:id)).to eq(
          [login_event_tracking.id, logout_event_tracking.id]
        )
      end
    end
  end
end
