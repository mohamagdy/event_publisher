class CreateEventPublisherEventTrackings < ActiveRecord::Migration
  def change
    create_table :event_publisher_event_trackings do |t|
      t.integer :trackable_id
      t.string :trackable_type
      t.integer :event_id
      t.string :ip
      t.string :operation_system

      t.timestamps
    end
  end
end
