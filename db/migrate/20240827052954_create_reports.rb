class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_study_time
      t.text :good_points
      t.text :improvement_points
      t.text :next_steps
      t.string :next_study_day
      t.text :feedback
      t.references :mentor, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
