class Event < ApplicationRecord
  belongs_to :group
  belongs_to :activity

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
