class Group < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :events, dependent: :destroy
end
