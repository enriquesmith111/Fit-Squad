class Event < ApplicationRecord
  belongs_to :group
  belongs_to :activity
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one :chatroom, dependent: :destroy  # Ensure the chatroom is destroyed when the event is deleted
  has_many :participants, through: :event_participants, source: :user
  after_create :create_associated_chatroom

  private

  def create_associated_chatroom
    chatroom = Chatroom.create(name:)
    update(chatroom:)
  end
end
