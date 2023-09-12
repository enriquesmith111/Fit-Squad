class CreateWorkoutPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :fitness_goal
      t.integer :days_per_week
      t.integer :time_per_session
      t.string :fitness_level
      t.text :additional_comments

      t.timestamps
    end
  end
end
