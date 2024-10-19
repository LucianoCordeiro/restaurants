class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.references :menu, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.decimal :price, precision: 7, scale: 2, null: false
      t.timestamps
    end
  end
end
