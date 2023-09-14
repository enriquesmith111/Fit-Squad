class Event < ApplicationRecord
  belongs_to :group
  belongs_to :activity
  has_many :event_participants
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one :chatroom, dependent: :destroy  # Ensure the chatroom is destroyed when the event is deleted

  after_create :create_associated_chatroom

  private

  def create_associated_chatroom
    chatroom = Chatroom.create(name: name)
    update(chatroom: chatroom)
  end
end
