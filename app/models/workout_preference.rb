class WorkoutPreference < ApplicationRecord
  belongs_to :user

  validates :fitness_goal, presence: true
  validates :days_per_week, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :time_per_session, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :fitness_level, presence: true
end
