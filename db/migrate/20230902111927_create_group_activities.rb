class CreateGroupActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :group_activities do |t|
      t.references :group, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
