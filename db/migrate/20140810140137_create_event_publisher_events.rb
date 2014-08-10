class CreateEventPublisherEvents < ActiveRecord::Migration
  def change
    create_table :event_publisher_events do |t|
      t.string :name

      t.timestamps
    end
  end
end
