class CreateEventPublisherAnonymousUsers < ActiveRecord::Migration
  def change
    create_table :event_publisher_anonymous_users do |t|

      t.timestamps
    end
  end
end
