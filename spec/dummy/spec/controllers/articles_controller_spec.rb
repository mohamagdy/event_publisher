require 'rails_helper'

RSpec.describe ArticlesController, :type => :controller do
  shared_examples "setting event publisher cookies" do |action, params|
    it "should save the cookies of the current logged in user" do
      get action, params
      expect(cookies.signed[:event_publisher_user_id]).to_not be_nil
      expect(cookies.signed[:event_publisher_user_type]).to_not be_nil
    end
  end

  context "signed in user" do
    include Devise::TestHelpers
    let(:user) { create(:user) }

    before(:each) do
      @request.env["devise.mapping"] = :user
      sign_in user
    end

    describe "non authenticated action" do
      it "tracks the user event for listing articles" do
        expect{
          get :index, {}
        }.to change{ EventPublisher::EventTracking.count }.by(1)
      end

      it_behaves_like "setting event publisher cookies", :index
    end

    describe "authenticated action" do
      it "tracks the user event for showing an article" do
        article = create(:article)
        expect{
          get :show, { id: article.to_param }
        }.to change{ EventPublisher::EventTracking.count }.by(1)
      end

      it_behaves_like "setting event publisher cookies", :show, { id: FactoryGirl.create(:article).to_param }
    end

    describe "tracking events after logging out" do
      it "should track user's events after logging out" do
        expect{
          get :index, {}
        }.to change{ user.event_trackings.count }.by(1)

        # Signing out the logged in user
        sign_out(user)

        expect{
          get :index, {}
        }.to change{ user.event_trackings.count }.by(1)
      end

      it "should not track events if cookies are deleted" do
        expect{
          get :index, {}
        }.to change{ user.event_trackings.count }.by(1)

        sign_out(user)

        # Removing the cookies
        cookies.delete(:event_publisher_user_id)
        cookies.delete(:event_publisher_user_type)

        expect{
          get :index, {}
        }.to change{ EventPublisher::EventTracking.count }.by(1)

        expect{
          get :index, {}
        }.to change{ user.event_trackings.count }.by(0)
      end
    end
  end

  context "non logged in user" do
    describe "non authenticated action" do
      it "should track the events for non logged in user without cookies saved before" do
        expect{
          get :index, {}
        }.to change{ EventPublisher::EventTracking.count }.by(1)
      end

      it "should track the events for non logged in user with cookies saved before" do
        anonymous_user = create(:event_publisher_anonymous_user)
        cookies.signed[:event_publisher_user_id] = anonymous_user.id

        # There should be only 1 anonymous user saved in the database
        expect(EventPublisher::AnonymousUser.count).to eq(1)
        expect(anonymous_user.event_trackings.count).to eq(0)

        expect{
          get :index, {}
        }.to change{ EventPublisher::EventTracking.count }.by(1)

        # No new anonymous user will be created
        expect(EventPublisher::AnonymousUser.count).to eq(1)
        expect(anonymous_user.event_trackings.count).to eq(1)
      end

      it "should log events for multiple non logged in users" do
        expect{
          get :index, {}
        }.to change{ EventPublisher::AnonymousUser.count }.by(1)

        cookies.delete(:event_publisher_user_id)
        cookies.delete(:event_publisher_user_type)

        expect{
          get :index, {}
        }.to change{ EventPublisher::AnonymousUser.count }.by(1)
      end

      it_behaves_like "setting event publisher cookies", :index
    end
  end

  context "first time to login user" do
    it "should save all the events user did before logging in" do
      number_of_events = 5
      anonymous_user = create(:event_publisher_anonymous_user)
      events = create_list(
        :event_publisher_event_tracking,
        number_of_events,
        trackable: anonymous_user
      )

      cookies.signed[:event_publisher_user_id] = anonymous_user.id
      cookies.signed[:event_publisher_user_type] = anonymous_user.class.name

      expect(anonymous_user.event_trackings.count).to eq(number_of_events)

      # Logging in
      user = create(:user)

      controller.after_sign_in_path_for(user)

      expect(user.event_trackings.count).to eq(number_of_events)
      expect(anonymous_user.reload.event_trackings.count).to eq(0)
    end
  end
end
