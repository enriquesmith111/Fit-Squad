class Event < ApplicationRecord
  belongs_to :group
  belongs_to :activity
  has_many :event_participants
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
