class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string "item_name", null: false
      t.text "item_image", null: false, foreign_key: true
      t.string "category_id", null: false, foreign_key: true
      t.string "brand", null: false, foreign_key: true
      t.integer "condition_id", null: false, foreign_key: true
      t.integer "postageplayer_id", null: false, foreign_key: true
      t.references "prefecture", null: false, foreign_key: true
      t.integer "shippingdate_id", null: false, foreign_key: true
      t.integer "price", null: false
      t.text "introduction", null: false
      t.integer "buyer_id", foreign_key: true
      t.timestamps
    end
  end
end
