class AddHiraganaToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :hiragana, :string
  end
end
