class AddWorkoutPlanToWorkoutPreferences < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_preferences, :workout_plan, :text
  end
end
