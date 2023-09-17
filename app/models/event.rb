class Event < ApplicationRecord

  include PgSearch::Model

  pg_search_scope :search_by_name_and_address,
    against: [:name, :address],
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_by_activity_name,
    associated_against: {
      activity: [:name] # Assuming 'name' is the attribute in the 'Activity' model you want to search against
    }

  multisearchable against: [:name, :address]
  belongs_to :group
  belongs_to :activity
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one :chatroom, dependent: :destroy  # Ensure the chatroom is destroyed when the event is deleted
  has_many :event_participants, dependent: :destroy
  after_create :create_associated_chatroom



  private

  def create_associated_chatroom
    chatroom = Chatroom.create(name:)
    update(chatroom:)
  end
end
