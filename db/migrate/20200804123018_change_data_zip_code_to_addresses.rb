class ChangeDataZipCodeToAddresses < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :zip_code, :string
  end
end
