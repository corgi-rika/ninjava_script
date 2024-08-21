class AddRoleAndCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, null: false
    add_column :users, :code, :string

    # code カラムに対して一意なインデックスを作成
    add_index :users, :code, unique: true
  end
end
