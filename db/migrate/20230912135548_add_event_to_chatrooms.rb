class AddEventToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :events, null: false, foreign_key: true
  end
end
