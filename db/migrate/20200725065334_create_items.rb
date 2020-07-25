class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name,          null:false
      t.text :item_image,           null: false, foreign_key: true
      t.string :seller,         null: false, foreign_key: true
      t.string :category,       null: false, foreign_key: true
      t.string :brand,          null: false, foreign_key: true
      t.string :size,           null: false, foreign_key: true
      t.string :condition,      null: false, foreign_key: true
      t.string :postage_player, null: false, foreign_key: true
      t.string :postage_type,   null: false, foreign_key: true
      # t.integer :prefecture_code,   null: false
      t.string :shipping_date,  null: false, foreign_key: true
      t.integer :price,             null: false
      t.text :introduction,         null: false
      t.string :buyer,          foreign_key: true
      t.timestamps
    end
  end

  t.references :prefecture_id, null: false,foreign_key: true
end
