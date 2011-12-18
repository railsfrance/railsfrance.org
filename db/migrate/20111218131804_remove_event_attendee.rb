class RemoveEventAttendee < ActiveRecord::Migration
  def up
    drop_table :event_attendees
  end

  def down
    create_table "event_attendees" do |t|
      t.integer "user_id"
      t.integer "event_id"
    end
  end
end
