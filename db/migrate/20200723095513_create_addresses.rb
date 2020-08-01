class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :zip_code, null: false
      t.string :prefecture, null: false
      t.string :municipality, null: false
      t.string :address, null: false
      t.string :apartment_name
      t.integer :phone_number, unique: true
      t.references :user,  foreign_key: true
      t.timestamps
    end
  end
end
