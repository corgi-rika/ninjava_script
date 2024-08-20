class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :word, null: false
      t.string :meaning, null: false
      t.text :example, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
