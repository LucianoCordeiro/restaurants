class CreateMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :menus do |t|
      t.references :restaurant, foreign_key: true, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
