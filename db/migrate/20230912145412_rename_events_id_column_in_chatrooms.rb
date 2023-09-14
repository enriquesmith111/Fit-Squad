class RenameEventsIdColumnInChatrooms < ActiveRecord::Migration[7.0]
  def change
    rename_column :chatrooms, :events_id, :event_id
  end
end
